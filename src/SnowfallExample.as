package {

    import flash.geom.Point;
    import flash.display.Sprite;

    import org.flintparticles.common.counters.*;
    import org.flintparticles.common.displayObjects.RadialDot;
    import org.flintparticles.common.initializers.*;
    import org.flintparticles.twoD.actions.*;
    import org.flintparticles.twoD.emitters.Emitter2D;
    import org.flintparticles.twoD.initializers.*;
    import org.flintparticles.twoD.renderers.*;
    import org.flintparticles.twoD.zones.*;

    [SWF(backgroundColor=0x000000, width=800, height=600)]

    public class SnowfallExample extends Sprite
    {
        private var emitter:Emitter2D = new Emitter2D();

        public function SnowfallExample():void
        {
            // Количество частиц, генерируемое в единицу времени
            emitter.counter = new Steady( 100 );


            // Визуально частицы будут выглядеть как круг с радиальным
            // размытием и радиусом два пикселя
            emitter.addInitializer( new ImageClass( RadialDot, [2] ) );

            // Начальное положение частиц
            emitter.addInitializer( new Position( new LineZone( new Point( -5, -5 ), new Point( 505, -5 ) ) ) );

            // Velocity -- инициализирует значение гравитации. Это значение
            // использует Action Move.
            emitter.addInitializer( new Velocity( new PointZone( new Point( 0, 65 ) ) ) );

            // Значение масштаба частицы может менятся от 75% до 200% от размера
            // графического объекта
            emitter.addInitializer( new ScaleImageInit( 0.75, 2 ) );

            // Action задает действие над частицей. Move изменяет x, y координаты частиц
            emitter.addAction( new Move() );

            // DeathZone убивает частицы -- удаляет их из генератора или помечает
            // не используемыми для повторного использования.
            emitter.addAction( new DeathZone( new RectangleZone( -10, -10, 520, 420 ), true ) );

            // RandomDrift изменяет позицию частицы на случайное число в
            // диапазоне x = {0..15}, y = {0..15}
            emitter.addAction( new RandomDrift( 15, 15 ) );

            // Дальше рендерер прикрепляется в нужное вам место в
            // display list и запускается генерация частиц.
            var renderer:DisplayObjectRenderer = new DisplayObjectRenderer();
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
