import textwrap

import clips
import PySimpleGUI as sg


def main():
    sg.theme("DarkBlue12")

    environment = clips.Environment()

    environment.load("online_games.clp")
    environment.reset()
    environment.run()

    message_template = environment.find_template('message')
    message = dict(list(message_template.facts())[0])

    buttons = ['b0', 'b1', 'b2', 'b3', 'b4', 'b5']
    options = message['answers']
    s = len(options)

    radio_buttons = [
        [sg.Radio(options[i], 2137, key=buttons[i], visible=(i < s), default=(i == -1), font=("Any", 13))] for i in
        range(s)
    ]

    layout = [
        [sg.Text(message['question'], font=('Arial', 18), key='quest')],
        radio_buttons,
        [sg.Button('Submit')]
    ]

    window = sg.Window("Find the right online game for yourself", layout, size=(700, 400), resizable=True)

    while True:
        event, values = window.read()
        if event == sg.WINDOW_CLOSED:
            break
        elif event == 'Submit':
            if len([x for x, y in values.items() if y is True]) > 0:
                value = [x for x, y in values.items() if y is True][0]
                environment.assert_string('({} "{}")'.format(message['name'], message['answers'][buttons.index(value)]))
                environment.run()

                message_list = list(message_template.facts())

                if message_list:
                    message = dict(message_list[0])
                    extracted_message = message['question']
                    new_message = textwrap.fill(extracted_message, 60)

                    window['quest'].update(value=new_message)

                    options = message['answers']
                    n = len(options)

                    for i in range(4):
                        window[buttons[i]].update(value=False)
                        if i < n:
                            window[buttons[i]].update(visible=True, text=options[i])
                        else:
                            window[buttons[i]].update(visible=False)
                else:
                    window.close()
                    break

    environment.run()
    res_template = environment.find_template('online-game')

    try:
        result = dict(list(res_template.facts())[0])
    except IndexError:
        exit()

    result_layout = [
        [sg.Text(result['name'], font='Any 20', pad=(10, 10))],
        [sg.Button("Close", size=(10, 2), pad=(30, 30))]
    ]

    result_window = sg.Window("Found game for you", result_layout, size=(500, 200), element_justification='c')

    while True:
        event, values = result_window.read()
        if event == sg.WINDOW_CLOSED or event == "Close":
            break


if __name__ == "__main__":
    main()
