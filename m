From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c_adapter.class and new style drivers
Date: Tue, 22 Jan 2008 10:55:37 -0500
Message-ID: <9e4733910801220755j45b4c48m467679ebdd2ef911@mail.gmail.com>
References: <9e4733910801211549v74ca13c4ya07179d36b35bff0@mail.gmail.com>
	<20080122152347.1ebd0f4c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080122152347.1ebd0f4c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 1/22/08, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Jon,
>
> On Mon, 21 Jan 2008 18:49:34 -0500, Jon Smirl wrote:
> > Is i2c_adapter.class relevant anymore with new style drivers?
>
> No, it's not. The class is meant to limit the probing scope of
> legacy i2c chip drivers. New-style i2c chip drivers shouldn't care.
>
> Note that these classes aren't going away anytime soon though: some
> chip types just have to be probed (e.g. hardware monitoring chips or
> EEPROMs on PC motherboards) so even if these drivers are eventually
> converted to new-style i2c chip drivers, some (possibly external)
> probing will still be necessary, and the class will be there to limit
> the scope of this probing.
>
> > On 1/2/08, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org> wrote:
> > > IMHO, there should be a node attribute to override
> > > i2c_adapter.class. Legacy i2c drivers (in particular v4l and dvb
> > > drivers) use this class to decide which adapter to bind to.
> > > dbox2 needs I2C_CLASS_TV_DIGITAL (4).
>
> I am fine with a node attribute allowing control of this attribute,
> that could be handy for testing and debugging purposes. If someone
> submits a patch implementing this, I'll review and merge it.

Wouldn't it be better to convert the v4l and dvd drivers to new style
and make progress on getting rid of class? It only takes about half an
hour to convert a driver and the conversion mostly involves deleting
code.

>
> --
> Jean Delvare
>


-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
