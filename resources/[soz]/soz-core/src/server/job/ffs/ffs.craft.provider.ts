import { OnEvent } from '../../../core/decorators/event';
import { Inject } from '../../../core/decorators/injectable';
import { Provider } from '../../../core/decorators/provider';
import { ServerEvent } from '../../../shared/event';
import { FfsConfig, Process } from '../../../shared/job/ffs';
import { Monitor } from '../../../shared/monitor';
import { toVector3Object, Vector3 } from '../../../shared/polyzone/vector';
import { InventoryManager } from '../../inventory/inventory.manager';
import { ItemService } from '../../item/item.service';
import { Notifier } from '../../notifier';
import { PlayerService } from '../../player/player.service';
import { ProgressService } from '../../player/progress.service';

@Provider()
export class FightForStyleCraftProvider {
    @Inject(ProgressService)
    private progressService: ProgressService;

    @Inject(InventoryManager)
    private inventoryManager: InventoryManager;

    @Inject(PlayerService)
    private playerService: PlayerService;

    @Inject(Notifier)
    private notifier: Notifier;

    @Inject(ItemService)
    private itemService: ItemService;

    @Inject(Monitor)
    private monitor: Monitor;

    @OnEvent(ServerEvent.FFS_CRAFT)
    public async onCraft(source: number, craftProcess: Process) {
        if (!this.canCraft(source, craftProcess)) {
            this.notifier.notify(source, `Vous n'avez pas les matériaux nécessaires pour confectionner.`, 'error');
            return;
        }

        this.notifier.notify(source, 'Vous ~g~commencez~s~ à confectionner.', 'success');

        while (this.canCraft(source, craftProcess)) {
            const hasCrafted = await this.doCraft(source, craftProcess);
            const outputItemLabel = this.itemService.getItem(craftProcess.output.id).label;
            if (hasCrafted) {
                this.monitor.publish(
                    'job_ffs_craft',
                    {
                        item_id: craftProcess.output.id,
                        player_source: source,
                    },
                    {
                        item_label: outputItemLabel,
                        quantity: craftProcess.output.amount,
                        position: toVector3Object(GetEntityCoords(GetPlayerPed(source)) as Vector3),
                    }
                );
                this.notifier.notify(source, `Vous avez confectionné un·e ~g~${outputItemLabel}~s~.`);
            } else {
                this.notifier.notify(source, 'Vous avez ~r~arrêté~s~ de confectionner.');
                return;
            }
        }
        this.notifier.notify(source, `Vous n'avez pas les matériaux nécessaires pour confectionner.`);
    }

    private canCraft(source: number, craftProcess: Process): boolean {
        for (const input of craftProcess.inputs) {
            const amount = this.inventoryManager.getItemCount(source, input.id);
            if (!amount || amount < input.amount) {
                return false;
            }
        }
        return this.inventoryManager.canSwapItem(
            source,
            craftProcess.inputs[0].id,
            craftProcess.inputs[0].amount,
            craftProcess.output.id,
            craftProcess.output.amount
        );
    }

    private async doCraft(source: number, craftProcess: Process) {
        const { completed } = await this.progressService.progress(
            source,
            'ffs_craft',
            'Confection en cours',
            FfsConfig.craft.duration,
            {
                name: 'base',
                dictionary: 'amb@prop_human_seat_sewing@female@base',
                flags: 16,
            }
        );

        if (!completed) {
            return false;
        }

        for (const input of craftProcess.inputs) {
            this.inventoryManager.removeItemFromInventory(source, input.id, input.amount);
        }
        this.inventoryManager.addItemToInventory(source, craftProcess.output.id, craftProcess.output.amount);
        return true;
    }
}
