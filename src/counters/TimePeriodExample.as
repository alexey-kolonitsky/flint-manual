package counters
{

    import emitters.StarsEmitter;

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import org.flintparticles.common.counters.Blast;
    import org.flintparticles.common.counters.TimePeriod;
    import org.flintparticles.common.displayObjects.Dot;
    import org.flintparticles.common.easing.Cubic;
    import org.flintparticles.common.initializers.ImageClass;
    import org.flintparticles.common.renderers.SpriteRendererBase;
    import org.flintparticles.twoD.renderers.BitmapRenderer;

    [SWF(backgroundColor=0x000000, width=620, height=400)]

    /**
     * @author Alexey Kolonitsky
     */
    public class TimePeriodExample extends ExampleBase
    {
        private var emitter:StarsEmitter;
        private var renderer:SpriteRendererBase;

        public function TimePeriodExample()
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
            emitter.counter = new TimePeriod(50, 1000, Cubic.easeIn);
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
