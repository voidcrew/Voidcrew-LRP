import { useBackend } from '../backend';
import { Box, Button, Dropdown, Flex, Icon, LabeledList, Modal, Section } from '../components';
import { Window } from '../layouts';

const CONSOLE_MODE_AUTOPILOT = 'autopilot';
const CONSOLE_MODE_SUBVERTER = 'subverter';

export const AuxConsole = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    authorization_required,
  } = data;
  const { consoleMode } = data.view;
  return (
    <Window
      width={350}
      height={300}>
      {!!authorization_required && (
        <Modal
          ml={1}
          mt={1}
          width={26}
          height={12}
          fontSize="28px"
          fontFamily="monospace"
          textAlign="center">
          <Flex>
            <Flex.Item mt={2}>
              <Icon
                name="minus-circle" />
            </Flex.Item>
            <Flex.Item
              mt={2}
              ml={2}
              color="bad">
              {'SHUTTLE LOCKED'}
            </Flex.Item>
          </Flex>
          <Box
            fontSize="18px"
            mt={4}>
            <Button
              lineHeight="40px"
              icon="arrow-circle-right"
              content="Request Authorization"
              color="bad" />
          </Box>
        </Modal>
      )}
      <Window.Content>
        <AuxConsoleCommands />
        {consoleMode === CONSOLE_MODE_AUTOPILOT && (
          <ShuttleConsoleContent />
        )}
        {consoleMode === CONSOLE_MODE_SUBVERTER && (
          <SubverterConsoleContent />
        )}
      </Window.Content>
    </Window>
  );
};

const getLocationNameById = (locations, id) => {
  return locations?.find(location => location.id === id)?.name;
};

const getLocationIdByName = (locations, name) => {
  return locations?.find(location => location.name === name)?.id;
};

const STATUS_COLOR_KEYS = {
  "In Transit": "good",
  "Idle": "average",
  "Igniting": "average",
  "Recharging": "average",
  "Missing": "bad",
  "Unauthorized Access": "bad",
  "Locked": "bad",
};

export const AuxConsoleCommands = (props, context) => {
  const { data, act } = useBackend(context);
  const { subverter } = data;
  const { consoleMode } = data.view;
  return (
    <Section title="Auxiliary Switches">
      <LabeledList>
        <LabeledList.Item label="Mode">
          <Button
            content="Autopilot"
            selected={consoleMode === CONSOLE_MODE_AUTOPILOT}
            onClick={() => act('set_view', {
              consoleMode: CONSOLE_MODE_AUTOPILOT,
            })} />
          <Button
            content="Interdictor"
            disabled={!subverter}
            selected={consoleMode === CONSOLE_MODE_SUBVERTER}
            onClick={() => act('set_view', {
              consoleMode: CONSOLE_MODE_SUBVERTER,
            })} />
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

const ShuttleConsoleContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    status,
    locked,
    authorization_required,
    destination,
    docked_location,
    timer_str,
    locations = [],
  } = data;
  return (
    <Section>
      <Box
        bold
        fontSize="26px"
        textAlign="center"
        fontFamily="monospace">
        {timer_str || "00:00"}
      </Box>
      <Box
        textAlign="center"
        fontSize="14px"
        mb={1}>
        <Box
          inline
          bold>
          STATUS:
        </Box>
        <Box
          inline
          color={STATUS_COLOR_KEYS[status] || "bad"}
          ml={1}>
          {status || "Not Available"}
        </Box>
      </Box>
      <Section
        title="Shuttle Controls"
        level={2}>
        <LabeledList>
          <LabeledList.Item label="Location">
            {docked_location || "Not Available"}
          </LabeledList.Item>
          <LabeledList.Item label="Destination">
            {locations.length===0 && (
              <Box
                mb={1.7}
                color="bad">
                Not Available
              </Box>
            ) || locations.length===1 &&(
              <Box
                mb={1.7}
                color="average">
                {getLocationNameById(locations, destination)}
              </Box>
            ) || (
              <Dropdown
                mb={1.7}
                over
                width="240px"
                options={locations.map(location => location.name)}
                disabled={locked || authorization_required}
                selected={getLocationNameById(locations, destination) || "Select a Destination"}
                onSelected={value => act('set_destination', {
                  destination: getLocationIdByName(locations, value),
                })} />)}
          </LabeledList.Item>
        </LabeledList>
        <Button
          fluid
          content="Depart"
          disabled={!getLocationNameById(locations, destination)
            || locked || authorization_required}
          icon="arrow-up"
          textAlign="center"
          onClick={() => act('move', {
            shuttle_id: destination,
          })} />
      </Section>
    </Section>
  );
};

const SubverterConsoleContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    status_b,
    locked_b,
    authorization_required,
    selected_target,
    recharge_time_str,
    ships = [],
  } = data;
  return (
    <Section>
      <Box
        bold
        fontSize="26px"
        textAlign="center"
        fontFamily="monospace">
        {recharge_time_str || "00:00"}
      </Box>
      <Box
        textAlign="center"
        fontSize="14px"
        mb={1}>
        <Box
          inline
          bold>
          STATUS:
        </Box>
        <Box
          inline
          color={STATUS_COLOR_KEYS[status] || "bad"}
          ml={1}>
          {status_b || "Not Available"}
        </Box>
      </Box>
      <Section
        title="Interdictor GUI"
        level={2}>
        <LabeledList>
          <LabeledList.Item label="Target">
            {ships.length===0 && (
              <Box
                mb={1.7}
                color="bad">
                Not Available
              </Box>
            ) || ships.length===1 &&(
              <Box
                mb={1.7}
                color="average">
                {getLocationNameById(ships, selected_target)}
              </Box>
            ) || (
              <Dropdown
                mb={1.7}
                over
                width="240px"
                options={ships.map(location => location.name)}
                disabled={locked_b || authorization_required}
                selected={getLocationNameById(ships, selected_target) || "Select a Target"}
                onSelected={value => act('set_subvert_target', {
                  selected_target: getLocationIdByName(ships, value),
                })} />)}
          </LabeledList.Item>
        </LabeledList>
        <Button
          fluid
          content="Subvert"
          disabled={!getLocationNameById(ships, selected_target)
            || locked_b || authorization_required}
          icon="arrow-up"
          textAlign="center"
          onClick={() => act('subvert', {
            shuttle_id: selected_target,
          })} />
      </Section>
    </Section>
  );
};
