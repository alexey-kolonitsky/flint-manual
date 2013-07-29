package {

    import flash.filters.BlurFilter;
    import flash.geom.Point;
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    import org.flintparticles.common.counters.*;
    import org.flintparticles.common.displayObjects.RadialDot;
    import org.flintparticles.common.displayObjects.Star;
    import org.flintparticles.common.initializers.*;
    import org.flintparticles.twoD.actions.*;
    import org.flintparticles.twoD.emitters.Emitter2D;
    import org.flintparticles.twoD.initializers.*;
    import org.flintparticles.twoD.renderers.*;
    import org.flintparticles.twoD.renderers.BitmapLineRenderer;
    import org.flintparticles.twoD.zones.*;

    [SWF(backgroundColor=0x000000, width=620, height=400)]

    public class SnowfallExample extends Sprite
    {
        private var emitter:Emitter2D = new Emitter2D();

        public function SnowfallExample():void
        {
            // Количество частиц, генерируемое в единицу времени
            emitter.counter = new Steady(100);

            // Визуально частицы будут выглядеть как круг с радиальным
            // размытием и радиусом два пикселя
            emitter.addInitializer(new ImageClass(Star, [2]));

            // Начальное положение частиц
            emitter.addInitializer(new Position(new DiscZone(0, 0, stage.stageHeight >> 1)));

            // Velocity -- инициализирует значение гравитации. Это значение
            // использует Action Move.
            emitter.addInitializer(new Velocity(new PointZone(new Point(0, 65))));

            // Значение масштаба частицы может менятся от 75% до 200% от размера
            // графического объекта
            emitter.addInitializer(new ScaleImageInit(0.75, 2));

            emitter.addInitializer(new ColorsInit([0xFFFF0000, 0xFFFF00FF, 0xFFFFFF00, 0xFF00FF00, 0xFF00FFFF], [1,1,1,1,1]));

            // Action задает действие над частицей. Move изменяет x, y координаты частиц
            emitter.addAction(new Move());

            // DeathZone убивает частицы -- удаляет их из генератора или помечает
            // не используемыми для повторного использования.
            var rect:RectangleZone = new RectangleZone(-10, -10, 640, 420);
            emitter.addAction(new DeathZone(rect, true));

            // RandomDrift изменяет позицию частицы на случайное число в
            // диапазоне x = {0..15}, y = {0..15}
            emitter.addAction( new RandomDrift( 15, 15 ) );

            // Дальше рендерер прикрепляется в нужное вам место в
            // display list и запускается генерация частиц.
            var renderer:BitmapRenderer = new BitmapRenderer(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
            renderer.addFilter(new BlurFilter());
            addChild( renderer );
            renderer.addEmitter( emitter );

            emitter.start();

            // специальный метод пропускает 10 тактов работы генератора, чтобы
            // сразу снежинки были вдоль всего экрана, а не начинали появляться
            // вверху экрана.
            emitter.runAhead( 10 );
        }


    }

}
