import { map } from 'common/collections';
import { useBackend, useLocalState } from '../../backend';
import {
  Button,
  Flex,
  LabeledList,
  Section,
  Table,
  Tabs,
  Collapsible,
} from '../../components';
import { ButtonConfirm } from '../../components/Button';
import { Window } from '../../layouts';

export const MissionManipulator = (props, context) => {
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  const { act } = useBackend(context);
  return (
    <Window
      title="Mission Manipulator"
      width={875}
      height={600}
      resizable
      theme="admin"
    >
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
            Ruin
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
            Outpost
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <MissionManipulatorRuin />}
        {tab === 2 && <MissionManipulatorOutpost />}
      </Window.Content>
    </Window>
  );
};

export const MissionManipulatorRuin = (props, context) => {
  const { act, data } = useBackend(context);
  const active_missions = data.active_missions || [];
  const inactive_missions = data.inactive_missions || [];
  return (
    <Section>
      <Table>
        {active_missions.map((mission) => (
          <Table.Row key={mission.ref}>
            <Table.Cell>
              <Button
                content="JMP"
                key={mission.ref}
                onClick={() =>
                  act('jump_to', {
                    ref: mission.ref,
                  })
                }
              />
              <Button
                content="VV"
                key={mission.ref}
                onClick={() =>
                  act('vv', {
                    ref: mission.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>{mission.name}</Table.Cell>
            <Table.Cell>{mission.location}</Table.Cell>
          </Table.Row>
        ))}
      </Table>
      <Table>
        {inactive_missions.map((mission) => (
          <Table.Row key={mission.ref}>
            <Table.Cell>
              <Button
                content="JMP"
                key={mission.ref}
                onClick={() =>
                  act('jump_to', {
                    ref: mission.ref,
                  })
                }
              />
              <Button
                content="VV"
                key={mission.ref}
                onClick={() =>
                  act('vv', {
                    ref: mission.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>{mission.name}</Table.Cell>
            <Table.Cell>{mission.location}</Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
};

export const MissionManipulatorOutpost = (props, context) => {
  const { act, data } = useBackend(context);
  const missions = data.missions || [];
  return (
    <Section>
      <Table>
        {missions.map((mission) => (
          <Table.Row key={mission.ref}></Table.Row>
        ))}
      </Table>
    </Section>
  );
};
