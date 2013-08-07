package emitters
{

    import flash.geom.Point;
    import flash.geom.Rectangle;

    import org.flintparticles.common.counters.Steady;
    import org.flintparticles.common.displayObjects.Star;
    import org.flintparticles.common.initializers.ColorsInit;
    import org.flintparticles.common.initializers.ImageClass;
    import org.flintparticles.common.initializers.InitializerBase;
    import org.flintparticles.twoD.actions.DeathZone;
    import org.flintparticles.twoD.actions.Move;
    import org.flintparticles.twoD.actions.RandomDrift;
    import org.flintparticles.twoD.emitters.Emitter2D;
    import org.flintparticles.twoD.initializers.Position;
    import org.flintparticles.twoD.initializers.Velocity;
    import org.flintparticles.twoD.zones.PointZone;
    import org.flintparticles.twoD.zones.RectangleZone;

    public class StarsEmitter extends Emitter2D
    {
        public static var colors:Array = [
            0xFFFF0000,
            0xFFFF00FF,
            0xFFFFFF00,
            0xFF00FF00,
            0xFF00FFFF
        ];

        public function StarsEmitter(start:Point, bounds:Rectangle,
            displayObjectInitializer:InitializerBase = null)
        {
            addInitializer(displayObjectInitializer || new ImageClass(Star, [4], true));
            addInitializer(new Position(new PointZone(start)));
            addInitializer(new Velocity(new PointZone(new Point(25, 0))));
            addInitializer(new ColorsInit(colors));

            var rect:RectangleZone = new RectangleZone(bounds.x, bounds.y, bounds.width, bounds.height);
            addAction(new Move());
            addAction(new DeathZone(rect, true));
            addAction( new RandomDrift( 10, 20 ) );
        }
    }
}
