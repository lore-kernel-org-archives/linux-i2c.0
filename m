From: vidhumouli hunsigida <hv_mouli-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Supporting new features in I2C
Date: Fri, 12 Sep 2008 06:35:43 -0700 (PDT)
Message-ID: <863377.52660.qm@web57102.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The I2C host controller chip has two features named
HOLD and Slave Monitor.

HOLD is the typical feature of holding the clock low to support for the slow devices.
It can be enabled or disabled through software control by writing a bit in the registor.

I am writing a bus driver for this core.
I am not sure where and how this provision is to be added in the I2C adapter code.

I could not find any such provision in the exising bus drivers.
I could not find any related information in the Linux kernel documentation.

Can any one give me how can this be done?

Similarly for Slave Monitor, where a host monitors for the ack received from the slave device.
This can also be enabled/disabled by setting a bit in the register. How is this to be handled in the current i2c adapter code?

Thanks.


      

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
