import { useBackend, useSharedState } from '../../backend';
import {
  Blink,
  Box,
  Button,
  Dimmer,
  Flex,
  Icon,
  Input,
  Modal,
  Section,
  TextArea,
  Tabs,
  Stack,
} from '../../components';
import { Window } from '../../layouts';

import { CargoCart } from './CargoCart';
import { CargoCatalog } from './CargoCatalog';
import { CargoData, SupplyPack } from './types';

export const MarketConsole = (props, context) => {
  const { act, data } = useBackend<CargoData>(context);
  const { supply_packs = [] } = data;
  const [tab, setTab] = useSharedState(context, 'outpostTab', 'catalog');

  return (
    <Window width={700} height={700} theme="ntos_terminal" resizable>
      <Window.Content>
        <Stack vertical fill>
          <Tabs>
            <Tabs.Tab
              icon="envelope"
              selected={tab === 'catalog'}
              onClick={() => setTab('catalog')}
            >
              Catalog
            </Tabs.Tab>
            <Tabs.Tab
              icon="shopping-cart"
              selected={tab === 'cart'}
              onClick={() => setTab('cart')}
            >
              Cart
            </Tabs.Tab>
          </Tabs>
          {tab === 'catalog' && <CargoCatalog />}
          {tab === 'cart' && <CargoCart />}
        </Stack>
      </Window.Content>
    </Window>
  );
};
