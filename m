From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: bcm2835: Model Divider in CCF
Date: Sun, 5 May 2019 10:13:34 -0700
Message-ID: <c43eb848-23cd-4b0c-638d-3bb0df58ed31@gmail.com>
References: <20190505034339.30778-1-nh6z@nh6z.net>
 <610c7594-85c9-72db-63a6-6e632e9586aa@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <610c7594-85c9-72db-63a6-6e632e9586aa-eS4NqCHxEME@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Annaliese McDermond <nh6z-fFIq/eER6g8@public.gmane.org>, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: team-ZZiVVnAreWfLmAkTNIzhqdBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 5/5/2019 3:36 AM, Stefan Wahren wrote:
> Hi Annaliese,
> 
> Am 05.05.19 um 05:43 schrieb Annaliese McDermond:
>> Model the I2C bus clock divider as a part of the Core Clock Framework.
>> Primarily this removes the clk_get_rate() call from each transfer.
>> This call causes problems for slave drivers that themselves have
>> internal clock components that are controlled by an I2C interface.
>> When the slave's internal clock component is prepared, the prepare
>> lock is obtained, and it makes calls to the I2C subsystem to
>> command the hardware to activate the clock.  In order to perform
>> the I2C transfer, this driver sets the divider, which requires
>> it to get the parent clock rate, which it does with clk_get_rate().
>> Unfortunately, this function will try to take the clock prepare
>> lock, which is already held by the slave's internal clock calls
>> creating a deadlock.
> 
> i think i understand the problem, but could you please explain the
> specific use case where this happend?
> 
> I suspect bcm2835 is not the only platform which is affected, so it
> would be better to fix this in general.

Agreed, if you could identify i2c bus drivers that support changing the
bus clock and move the registration of the bus 'struct clk' into the i2c
core that would scale a lot better.
-- 
Florian
