# QCatGrayQuick

QCatGrayQuick is a UI base library based on QtQuick. The library supports qt5.12+ and qt6.


## Examples

| Project | README |
|:--:|:--:|
| catgrayquicktest | QCatGrayQuick library call case |
| qrencodeqml | QCatGrayQuick library QR code invocation case |


## Submodule

CmakeLists.txt in the QCatGrayQuick main directory is responsible for introducing the submodules of the src directory, each of which does not directly depend on each other.

### qml(QCatGrayQuick)

The qml folder is provided in the src directory, which contains the basic control implementation of QtQuick UI. The internal version has been divided into qt5 and qt6, which can automatically identify qt5 and qt6.



### QCatGrayQuickChatModel

The chat component, the chat underlying business implemented by c++, and the CatChatView front-end code implemented by QML are used together.

### QCatGrayQuickQrenCodeQml

Two-dimensional code component.

### QCatGrayQuickTableViewModel

Table components, table underlying business is implemented by c++, CatTableView front-end code is implemented by QML.

## Quick-start your own project


* Project submodule initialization.

```
git submodule update --init --recursive
```

* cmake 

```cmake
# cmake
add_subdirectory(QCatGrayQuick)

target_link_libraries(${PROJECT_NAME}
  PRIVATE QCatGrayQuickQrenCodeQml_a)
```

* main.cpp
```c++
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QResource>
#include "QCatGrayQuickPlugins.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    QCatGrayQuickPlugins catgrayquickplugins;
    catgrayquickplugins.InitQCatGrayQuickPlugins(&engine);
    const QUrl mainQmlUrl(QStringLiteral("qrc:///qml/main.qml"));

    qDebug() << "importPathList: " << engine.importPathList() ;

    const QMetaObject::Connection connection = QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [&mainQmlUrl, &connection](QObject *object, const QUrl &url) {
            if (url != mainQmlUrl) {
                return;
            }
            if (!object) {
                QGuiApplication::exit(-1);
            } else {
                QObject::disconnect(connection);
            }
        },
        Qt::QueuedConnection);

    engine.load(mainQmlUrl);

    return app.exec();
}

```

* main.qml

```qml
import QtQuick 2.12
import QtQuick.Window 2.12
import QCatGrayQuick 1.0

Window {
    id: root
    visible: true
    width: 800
    height: 600

    CatButton {
        width: 200
        height: 100
        anchors.centerIn: parent
    }
}

```