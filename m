From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: IOCTL implementation in i2c Hostt/master controllers
Date: Tue, 2 Sep 2008 09:02:18 +0200
Message-ID: <20080902090218.2604df0d@hyperion.delvare>
References: <463640.33128.qm@web57114.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <463640.33128.qm-tLTVmYjyaXCB9c0Qi4KiSs0jms80CZx+QQ4Iyu8u01E@public.gmane.org>
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

On Mon, 1 Sep 2008 22:30:10 -0700 (PDT), vidhumouli hunsigida wrote:
> I forgot to ask the question.....
> 
> Can any one give me a poointer to any link/document from where
> I can understand the flow correctly?

The only document we have is Documentation/i2c/dev-interface in the
kernel source tree:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob_plain;f=Documentation/i2c/dev-interface

However it describes the API to /dev/i2c-N, not the flow from your
application to the I2C bus driver. For that, maybe the best we have is
this picture:
http://www.lm-sensors.org/attachment/wiki/Documentation/layers.gif
But it's not necessarily very clear.

(And it shouldn't be on the lm-sensors.org wiki, but that's another
story.)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
