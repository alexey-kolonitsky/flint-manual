package
{

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class ExampleBase extends Sprite
    {
        public function ExampleBase()
        {
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        protected function addedToStageHandler(event:Event):void
        {
            stage.scaleMode = "noScale";
            stage.align = "TL";

            stage.addEventListener(Event.ENTER_FRAME, stage_enterFrameHandler);
            stage.addEventListener(MouseEvent.CLICK, stage_clickHandler);

            createPlayButton();
        }

        protected function stage_clickHandler(event:MouseEvent):void
        {

        }

        private function stage_enterFrameHandler(event:Event):void
        {
            redraw();
        }



        private function createPlayButton():void
        {
            var stageWidth2:int = stage.stageWidth >> 1;
            var stageHeight2:int = stage.stageHeight >> 1;

            var s:Sprite = new Sprite();
            s.graphics.beginFill(0xFF0000, 1.0);
            s.graphics.drawTriangles(new <Number>[0, 0, 10, 5, 0, 10]);
            s.graphics.endFill();
            s.scaleX = 3.0;
            s.scaleY = 3.0;
            s.x = stageWidth2 - (s.width >> 1);
            s.y = stageHeight2;

            var tf:TextField = new TextField();
            tf.border = false;
            tf.borderColor = 0xFF0000;
            tf.width = 60;
            tf.autoSize = TextFieldAutoSize.CENTER;
            tf.defaultTextFormat = new TextFormat("_sans", 18, 0xFFFFFF);
            tf.selectable = false;
            tf.text = "start()";
            tf.x = stageWidth2 - (tf.width >> 1);
            tf.y = stageHeight2 + s.height;

            addChild(s);
            addChild(tf);
        }

        protected var drawQueue:Array = [];

        private function redraw():void
        {
            var n:int = drawQueue.length;

            graphics.clear();
            graphics.lineStyle(1, 0xFF0000, 1.0, true);
            graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);

            for (var i:int = 0; i < n; i++)
            {
                var figure:Object = drawQueue[i];
                if (figure is Rectangle)
                    drawRectangle(figure as Rectangle);
                if (figure is Point)
                    drawPoint(figure as Point);
            }
        }

        private function drawPoint(figure:Point):void
        {
            graphics.endFill();
            graphics.lineStyle(1, 0xFFFFFF, 1, false);
            graphics.drawCircle(figure.x - 2,  figure.y - 2,  4);
        }

        private function drawRectangle(figure:Rectangle):void
        {

        }
    }
}
