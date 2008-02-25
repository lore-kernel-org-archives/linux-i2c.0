From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PCA954x I2C switch/multiplexer
Date: Mon, 25 Feb 2008 09:02:37 +0100
Message-ID: <20080225090237.200b5b88@hyperion.delvare>
References: <200802231707.01967.roa@libero.it>
	<A42C17A8FF150C4DB98BFD6497D1D000081DF898@ussvlexmbpf1.spansion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D000081DF898-SepvG4MK2K7XgKAwtTS8dDuQPtp/YR6JAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Edelhaeuser, Frank" <Frank.Edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, ROASCIO Paolo <roa-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Frank,

On Sun, 24 Feb 2008 21:41:54 -0800, Edelhaeuser, Frank wrote:
> The driver I submitted implements the "new style" driver model. These
> driver's don't probe the bus automatically. Instead, devices must be
> instantiated by calling i2c_register_board_info() for each multiplexer
> device. Please note that this driver implements a special syntax for the
> type field: e.g. .type = "pxa9544,5" tells the driver to create 4
> virtual i2c buses with ids 5, 6, 7 and 8. You would
> i2c_register_board_info() your PXA9544 multiplexer with the root i2c bus
> and your bus segment devices with those virtual i2c buses.

Please don't abuse the type field, instead define a custom structure
and pass it to the driver as platform data. This will give you much
more flexibility as well.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
