package shop;

import haxe.display.Display.Package;

class Shop {
    private var queue:ShopQueue;

    public function new() {
        queue = new ShopQueue(function(m1:Market, m2:Market) {
            return m1.price() - m2.price();
        });


        // Upgrades

        var battery = new Market("battery", 2, 1, 1, 'B');

        battery.callback = function() {Player.battery = true;};

        queue.push(battery);

        var sight2:Market = new Market("sight", 3, 0, 2, 'D');
        var sight3:Market = new Market("sight", 6, 1, 3, 'D');

        sight2.callback = function() {Player.sight = 2;};
        sight3.callback = function() {Player.sight = 3;};

        queue.push(sight2);
        queue.push(sight3);

        var dig2:Market = new Market("dig", 3, 0, 2, 'D');
        var dig3:Market = new Market("dig", 6, 1, 3, 'D');

        dig2.callback = function() {Player.level = 2;};
        dig3.callback = function() {Player.level = 3;};

        queue.push(dig2);
        queue.push(dig3);
    }

    public function checkToBuy(iron:Int, osmium:Int):Market {
        var cheapest:Market = queue.first();

        if(cheapest == null) {
            trace("All items have been bought.");
            return null;
        }

        if(cheapest.iron > iron || cheapest.osmium > osmium) {
            return null;
        }
        
        return queue.pop();
    }
}