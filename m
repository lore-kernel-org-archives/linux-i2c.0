From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c_adapter.class and new style drivers
Date: Mon, 21 Jan 2008 18:49:34 -0500
Message-ID: <9e4733910801211549v74ca13c4ya07179d36b35bff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Is i2c_adapter.class relevant anymore with new style drivers?

On 1/2/08, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 1/2/08, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org> wrote:
> > IMHO, there should be a node attribute to override i2c_adapter.class. Legacy i2c drivers (in particular v4l and dvb drivers) use this class to decide which adapter to bind to. dbox2 needs I2C_CLASS_TV_DIGITAL (4).
>
> I hadn't paid any attention to i2c_adapter.class. Now that you mention
> it I wonder why i2c has it.  It appears to be a holdover from the
> older mechanism of searching for devices and it is used as a filter to
> reduce the number of device being searched. I would think a new style
> driver could just ignore it.
>
> It is probably best to fix it in a successive patch.
>

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
