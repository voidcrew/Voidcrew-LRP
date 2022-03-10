import { sortBy } from 'common/collections';
import { flow } from 'common/fp';
import { useBackend } from '../backend';
import { Box, Button, Dropdown, Section, Knob, LabeledControls, LabeledList } from '../components';
import { Window } from '../layouts';

export const adv_cassette_deck = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    active,
    track_selected,
    track_length,
    track_beat,
    volume,
  } = data;
  const songs = flow([
    sortBy(
      song => song.name),
  ])(data.songs || []);
  return (
    <Window
      width={370}
      height={313}>
      <Window.Content>
        <Section
          title="Song Player"
          buttons={(
            <Button
              icon={'play'}
              content={'Add Song To Cassette'}
              onClick={() => act('toggle')} />
          )}>
          <LabeledList>
            <LabeledList.Item label="Track Selected">
              <Dropdown
                overflow-y="scroll"
                width="240px"
                options={songs.map(song => song.name)}
                disabled={active}
                selected={track_selected || "Select a Track"}
                onSelected={value => act('select_track', {
                  track: value,
                })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
