#include "mousememory.h"

MouseMemory::MouseMemory(QObject *parent) : QObject(parent)
{

}

void MouseMemory::test()
{
//    qDebug() << "Hello From C++";
}

void MouseMemory::clear()
{
    qDebug() << "Clear the data";
}

void MouseMemory::save()
{
    qDebug() << "Save the data";
}

void MouseMemory::add(double x, double y)
{
    QPoint p(x, y);
//    qDebug() << "Adding " << p;
}

void MouseMemory::add(QPointF point)
{
    qDebug() << "Clear Float" << point;
}
