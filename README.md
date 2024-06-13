# Corporate social network

Версия Python - **Python 3.11**

Используемые модули:
* [os](https://docs.python.org/3/library/os.html)
* [playsound 1.3.0](https://pypi.org/project/playsound/)
* [random](https://docs.python.org/3/library/random.html)
* [speech_recognition 3.10.1](https://pypi.org/project/SpeechRecognition/)


Учебные материалы:
* [youtube](https://www.youtube.com/watch?v=ZZVWae8E9K0&t=1s)



## Устройство приложения
Импортируем модули и создаём рекогнайзер речи **sr**:

```python
import os
from playsound import playsound
import random
import speech_recognition

sr = speech_recognition.Recognizer()
```

Словарь с *голосовыми* командами:
```python
commands_dict = {
    'commands':{
            'greeting': ['привет', 'добрый день', 'здравствуйте'],
            'play_music' : ['включи музыку', 'включи песню', 'включи трек'],
            'create_task' : ['добавь задание', 'добавь задачу'],
        }
}
```

Прослушивание речи:
```python
def listen_command():
    try:
        with speech_recognition.Microphone() as mic:
            sr.adjust_for_ambient_noise(source=mic, duration=0.5)
            audio = sr.listen(source=mic)
            query = sr.recognize_google(audio_data=audio, language='ru-RU').lower()
            return query
    except speech_recognition.UnknownValueError:
        return 'Речь не распознана'
```

Приветствие:
```python
def greeting():
    return "Здравствуйте. Я ваш голосовой помощник."
```

Проигрывание *музыки*:
```python
def play_music():
    files = os.listdir('music')
    random_file = f'music/{random.choice(files)}'
    print(f'Включаю {random_file.split("/")[-1]}')
    playsound(random_file)
    return 0
```

*Task-manager*:
```python
def create_task():
    print("Скажите, что мне добавить в список дел.")

    query = listen_command()

    with open('todo-list.txt', 'a') as file:
        file.write(f'{query}\n')

    return f'Задача {query} добавлена в todo-list!'
```

Основное устройство программы - функция **main**
```python
def main():
    query = listen_command()
    print(query)
    for a, b in commands_dict['commands'].items():
        if query in b:
            print(globals()[a]())
```
