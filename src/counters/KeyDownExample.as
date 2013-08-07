package counters
{

    import emitters.StarsEmitter;

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.ui.Keyboard;

    import org.flintparticles.common.counters.Blast;
    import org.flintparticles.common.counters.KeyDownCounter;
    import org.flintparticles.common.displayObjects.Dot;
    import org.flintparticles.common.initializers.ImageClass;
    import org.flintparticles.common.renderers.SpriteRendererBase;
    import org.flintparticles.twoD.renderers.BitmapRenderer;

    [SWF(backgroundColor=0x000000, width=620, height=400)]

    /**
     * @author Alexey Kolonitsky
     */
    public class KeyDownExample extends ExampleBase
    {
        private var emitter:StarsEmitter;
        private var renderer:SpriteRendererBase;

        public function KeyDownExample()
        {
            super();
        }

        override protected function addedToStageHandler(event:Event):void
        {
            super.addedToStageHandler(event);

            var start:Point = new Point(10, stage.stageHeight / 2);
            var canvas:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            drawQueue.push(start);
            drawQueue.push(canvas);

            emitter = new StarsEmitter(start, canvas, new ImageClass(Dot, [3], true));
            emitter.counter = new KeyDownCounter(new Blast(), Keyboard.G, stage);
            renderer = new BitmapRenderer(canvas, false);
            addChild( renderer );
            renderer.addEmitter( emitter );
        }

        override protected function stage_clickHandler(event:MouseEvent):void
        {
            super.stage_clickHandler(event);

            if (emitter.running)
                emitter.pause();
            else
                emitter.start();
        }
    }
}
