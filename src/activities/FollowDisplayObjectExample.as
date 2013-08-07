package activities
{

    import emitters.DriftStarsEmitter;

    import flash.display.Sprite;

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import org.flintparticles.common.renderers.SpriteRendererBase;
    import org.flintparticles.twoD.activities.FollowDisplayObject;
    import org.flintparticles.twoD.renderers.BitmapRenderer;

    [SWF(backgroundColor=0x000000, width=620, height=400)]

    /**
     * @author Alexey Kolonitsky
     */
    public class FollowDisplayObjectExample extends ExampleBase
    {
        private var start:Point = new Point(0, 0);
        private var emitter:DriftStarsEmitter;
        private var renderer:SpriteRendererBase;

        public function FollowDisplayObjectExample()
        {
            super();
        }

        override protected function addedToStageHandler(event:Event):void
        {
            super.addedToStageHandler(event);

            var target:Sprite = new Sprite();
            target.graphics.beginFill(0xFF0000, 1.0);
            target.graphics.drawTriangles(new <Number>[-3, 0, 0, -3, 3, 0, -3, 0, 0, 3, 3, 0]);
            target.graphics.endFill();
            target.startDrag(true);
            target.scaleX = target.scaleY = 3;
            addChild(target);

            var canvas:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            drawQueue.push(start);
            drawQueue.push(canvas);

            renderer = new BitmapRenderer(canvas, false);
            addChild( renderer );

            emitter = new DriftStarsEmitter(start, canvas);
            emitter.addActivity(new FollowDisplayObject(target, renderer));

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
