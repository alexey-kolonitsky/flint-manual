
package
{

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import org.flintparticles.common.counters.Steady;
    import org.flintparticles.common.displayObjects.Star;
    import org.flintparticles.common.initializers.ColorsInit;
    import org.flintparticles.common.initializers.ImageClass;
    import org.flintparticles.common.initializers.ScaleImageInit;
    import org.flintparticles.twoD.actions.DeathZone;
    import org.flintparticles.twoD.actions.Move;
    import org.flintparticles.twoD.actions.RandomDrift;
    import org.flintparticles.twoD.emitters.Emitter2D;
    import org.flintparticles.twoD.initializers.Position;
    import org.flintparticles.twoD.initializers.Velocity;
    import org.flintparticles.twoD.renderers.DisplayObjectRenderer;
    import org.flintparticles.twoD.zones.PointZone;
    import org.flintparticles.twoD.zones.RectangleZone;

    [SWF(backgroundColor=0x000000, width=620, height=400)]

    /**
     * @author Alexey Kolonitsky
     */
    public class DisplayObjectEmitterExample extends ExampleBase
    {
        private var emitter:Emitter2D = new Emitter2D();

        public function DisplayObjectEmitterExample()
        {
            super();
        }

        override protected function addedToStageHandler(event:Event):void
        {
            super.addedToStageHandler(event);

            // Начальное положение частиц
            var emitterPosition:Point = new Point(10, stage.stageHeight >> 1);
            drawQueue.push(emitterPosition);

            // Количество частиц, генерируемое в единицу времени
            emitter.counter = new Steady(100);

            // Визуально частицы будут выглядеть как круг с радиальным
            // размытием и радиусом два пикселя
            emitter.addInitializer(new ImageClass(Star, [2]));

            emitter.addInitializer(new Position(new PointZone(emitterPosition)));

            // Velocity -- инициализирует значение гравитации. Это значение
            // использует Action Move.
            emitter.addInitializer(new Velocity(new PointZone(new Point(25, 0))));

            // Значение масштаба частицы может менятся от 75% до 200% от размера
            // графического объекта
            emitter.addInitializer(new ScaleImageInit(2.0, 3.0));

            emitter.addInitializer(new ColorsInit([0xFFFF0000, 0xFFFF00FF, 0xFFFFFF00, 0xFF00FF00, 0xFF00FFFF], [1,1,1,1,1]));

            // Action задает действие над частицей. Move изменяет x, y координаты частиц
            emitter.addAction(new Move());

            // DeathZone убивает частицы -- удаляет их из генератора или помечает
            // не используемыми для повторного использования.
            var rect:RectangleZone = new RectangleZone(-10, -10, stage.stageWidth + 20, stage.stageHeight + 20);
            emitter.addAction(new DeathZone(rect, true));

            // RandomDrift изменяет позицию частицы на случайное число в
            // диапазоне x = {0..15}, y = {0..15}
            emitter.addAction( new RandomDrift( 10, 20 ) );

            // Дальше рендерер прикрепляется в нужное вам место в
            // display list и запускается генерация частиц.
            var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
            addChild( renderer );
            renderer.addEmitter( emitter );
        }

        override protected function stage_clickHandler(event:MouseEvent):void
        {
            super.stage_clickHandler(event);

            if (emitter.running)
            {
                emitter.pause();
                trace("emitter.stop()");
            }
            else
            {
                emitter.start();
                trace("emitter.start()")
            }
        }
    }
}
