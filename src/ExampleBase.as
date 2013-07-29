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
            if (playIcon)
            {
                removeChild(playIcon);
                playIcon = null;
            }

            if (playText)
            {
                removeChild(playText);
                playText = null;
            }
        }

        private static const UI_COLOR:uint = 0x666666;

        private var playIcon:Sprite;
        private var playText:TextField;

        private function stage_enterFrameHandler(event:Event):void
        {
            redraw();
        }

        private function createPlayButton():void
        {
            var stageWidth2:int = stage.stageWidth >> 1;
            var stageHeight2:int = stage.stageHeight >> 1;

            playIcon = new Sprite();
            playIcon.graphics.beginFill(UI_COLOR, 1.0);
            playIcon.graphics.drawTriangles(new <Number>[0, 0, 10, 5, 0, 10]);
            playIcon.graphics.endFill();
            playIcon.scaleX = 3.0;
            playIcon.scaleY = 3.0;
            playIcon.x = stageWidth2 - (playIcon.width >> 1);
            playIcon.y = stageHeight2;

            playText = new TextField();
            playText.border = false;
            playText.borderColor = UI_COLOR;
            playText.width = 60;
            playText.autoSize = TextFieldAutoSize.CENTER;
            playText.defaultTextFormat = new TextFormat("_sans", 18, UI_COLOR);
            playText.selectable = false;
            playText.text = "click to start";
            playText.x = stageWidth2 - (playText.width >> 1);
            playText.y = stageHeight2 + playIcon.height;

            addChild(playIcon);
            addChild(playText);
        }

        protected var drawQueue:Array = [];

        private function redraw():void
        {
            var n:int = drawQueue.length;

            graphics.clear();
            graphics.lineStyle(1, UI_COLOR, 1.0, true);
            graphics.drawRect(0, 0, stage.stageWidth -1, stage.stageHeight -1);

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
