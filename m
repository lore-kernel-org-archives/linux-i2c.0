From: "Edelhaeuser, Frank" <Frank.Edelhaeuser-CBC/uQSf1AZWk0Htik3J/w@public.gmane.org>
Subject: Re: PCA954x I2C switch/multiplexer
Date: Sun, 24 Feb 2008 21:41:54 -0800
Message-ID: <A42C17A8FF150C4DB98BFD6497D1D000081DF898@ussvlexmbpf1.spansion.com>
References: <200802231707.01967.roa@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <200802231707.01967.roa-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: ROASCIO Paolo <roa-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The driver I submitted implements the "new style" driver model. These
driver's don't probe the bus automatically. Instead, devices must be
instantiated by calling i2c_register_board_info() for each multiplexer
device. Please note that this driver implements a special syntax for the
type field: e.g. .type = "pxa9544,5" tells the driver to create 4
virtual i2c buses with ids 5, 6, 7 and 8. You would
i2c_register_board_info() your PXA9544 multiplexer with the root i2c bus
and your bus segment devices with those virtual i2c buses.

Regards,
-Frank

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
