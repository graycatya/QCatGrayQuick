﻿import QtQuick 2.12 
import QtQuick.Shapes 1.12

Rectangle {
    id: root
 
    color: "transparent"
    width: 46; height: 46
    //anchors.centerIn: parent
    antialiasing: true
    //property variant styles: [ ShapePath.FlatCap, ShapePath.SquareCap, ShapePath.RoundCap ]
    //圆形进度背景
    property alias backdropstrokeColor: backdrop.strokeColor   
    //property alias backdropstrokeWidth: backdrop.strokeWidth

    //进度条背景起始角度
    property alias backdroparcstartAngle: backdroparc.startAngle
    //进度条背景当前角度
    property alias backdroparcsweepAngle: backdroparc.sweepAngle


    //进度条
    property alias progressbarstrokeColor: progressbar.strokeColor   

    //进度条起始角度
    property alias progressbararcstartAngle: progressbararc.startAngle
    //进度条当前角度
    property alias progressbararcsweepAngle: progressbararc.sweepAngle
    //
    property alias running: sequentialAnimation.running
    property alias to: numberAnimation.to  
    property alias duration: numberAnimation.duration

    //一下为重用变量
    //圆X，Y半径
    property int radiusX: 46
    property int radiusY: 46

    property int capStyle: ShapePath.FlatCap
    property int strokeWidth: 10
    

    Shape {
        //anchors.centerIn: parent
        width: root.width; height: root.height
        antialiasing: true

        ShapePath {
            id: backdrop
            fillColor: "transparent"
            strokeColor: "darkBlue"
            strokeWidth: root.strokeWidth
            capStyle: root.capStyle

            PathAngleArc {
                id: backdroparc
                centerX: root.width/2; centerY: root.height/2
                radiusX: root.radiusX; radiusY: root.radiusY
                startAngle: -180
                sweepAngle: 90
            }

        }
    }

    Shape {
        //anchors.centerIn: parent
        width: root.width; height: root.height
        antialiasing: true
        
        ShapePath {
            id: progressbar
            fillColor: "transparent"
            strokeColor: "gray"
            strokeWidth: root.strokeWidth
            capStyle: root.capStyle

            PathAngleArc {
                id: progressbararc
                centerX: root.width/2; centerY: root.height/2
                radiusX: root.radiusX; radiusY: root.radiusY
                startAngle: -180
                //sweepAngle: 15
                SequentialAnimation on sweepAngle {
                    id: sequentialAnimation
                    loops: Animation.Infinite
                    running: false
                    NumberAnimation{
                        id: numberAnimation
                        from: 0
                        to: 90; 
                        duration: 2000;
                    }
                }
            }

        }
    }
}

