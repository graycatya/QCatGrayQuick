import QtQuick 2.12
import com.catgray.QCatGrayQuickTableViewModel 1.0
import com.catgray.QCatGrayQuickTableViewModelStruct 1.0
import com.catgray.QCatGrayQuickTableViewHeaderStruct 1.0

Rectangle {
    id: root
    color: "transparent"
    clip: true
    property var headerTableData: null
    property int columnIndex: -1
    property int rowIndex: -1
    property var datamodel: null
    property bool isheaderFreeze: false
    width: datamodel ?
               datamodel.getHeaderStruct(rowIndex) !== null ?
                   datamodel.getHeaderStruct(rowIndex).preferredWidth
                 : 0
                 : 0
    height: datamodel.getStruct(columnIndex).preferredHeight
    // Component.onDestruction: {
    //     console.log("rowIndex: " + rowIndex)
    //     console.log("onDestruction datamodel: " + datamodel)
    // }
    // Component.onCompleted: {
    //     console.log("rowIndex: " + rowIndex)
    //     console.log("onCompleted datamodel: " + datamodel)
    // }
}
