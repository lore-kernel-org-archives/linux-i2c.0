From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: IOCTL implementation in i2c Host/master controllers
Date: Tue, 2 Sep 2008 10:02:33 +0200
Message-ID: <20080902100233.78288dc6@hyperion.delvare>
References: <948872.19896.qm@web57111.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <948872.19896.qm-YcYRh0kR1E2B9c0Qi4KiSs0jms80CZx+QQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: vidhumouli hunsigida <hv_mouli-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Vidhumouli,

On Mon, 1 Sep 2008 22:21:51 -0700 (PDT), vidhumouli hunsigida wrote:
> I am trying to understand how the ioctl call flow happens in the
> i2c driver in Linux. I=A0mean the flow from ioctl in application to
> lowerlest level of driver call?

Here's what happens, from your program (top) to the I2C adapter
(bottom):

1* Your program opens /dev/i2c-N and calls ioctl() on it. More often
than not, you'll use helper functions from <linux/i2c-dev.h> (the one
that ships in the i2c-tools package) for that.

2* These open() and ioctl() calls are handled by the i2c-dev kernel
driver: i2c-dev.c:i2cdev_open() and i2c-dev.c:i2cdev_ioctl(),
respectively. You can think of i2c-dev as a generic I2C chip driver
that can be programmed from user-space.

3* Some ioctl() calls are for administrative tasks and are handled by
i2c-dev directly. Examples include I2C_SLAVE (set the address of the
device you want to access) and I2C_PEC (enable SMBus error checking on
future transactions.)

4* Other ioctl() are converted to in-kernel function calls by i2c-dev.
Examples include I2C_FUNCS, which queries the I2C adapter functionality
using i2c.h:i2c_get_functionality(), and I2C_SMBUS, which performs an
SMBus transaction using i2c-core.c:i2c_smbus_xfer().

The i2c-dev driver is responsible for checking all the parameters that
come from user-space for validity. At this point in the flow, there is
no difference between these calls that came from user-space through
i2c-dev and calls that would have been performed by I2C chip kernel
drivers directly. This means that I2C bus drivers don't need to
implement anything special to support access from user-space.

5* These i2c-core.c/i2c.h functions are wrappers to the actual
implementation of your I2C bus driver. Each adapter must declare
callback functions implementing these standard calls.
i2c.h:i2c_get_functionality() calls i2c_adapter.algo->functionality(),
while i2c-core.c:i2c_smbus_xfer() calls either
adapter.algo->smbus_xfer() if it is implemented, or if not,
i2c-core.c:i2c_smbus_xfer_emulated() which in turn calls
adapter.algo->master_xfer().

After your I2C bus driver has processed these requests, execution runs
up the call chain, with almost no processing done, except by i2c-dev to
package the returned data, if any, in suitable format for the ioctl.

I hope this answers your question. I may add this explanation at the
end of Documentation/i2c/dev-interface if people think it is useful.

-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
