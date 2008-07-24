From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Thu, 24 Jul 2008 21:26:40 +0300
Message-ID: <31e679430807241126l5bcea400ieafcfa082d11783a@mail.gmail.com>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
	<1216909598.4888911eb6cea@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1216909598.4888911eb6cea-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
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
To: fuhz-GANU6spQydw@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

sorry pressed the send button by mistake.

read below

On Thu, Jul 24, 2008 at 5:26 PM,  <fuhz-GANU6spQydw@public.gmane.org> wrote:
> I am not using the last snapshot of Linux, but the 2.6.23 release.
> My source code is not completly up-to-date.
>
> For example there is no reference of I2C_BOARD_INFO in board-h4.
> I have no 'i2c_device_id menelaus_id[]' in the i2c drivers code.
>
> Perhap's that's why I am quite confuse, I am refering to recent code examples
> and I am using not-so-recent Linux version.

might be. Why are you using 2.6.23 and not 2.6.26 ?

Anyways, in 2.6.23 there was no i2c_device_id, so you can drop that comment.

But if you have to give the same name in the driver and in the i2c_board_info().

something like:

board file:

struct i2c_board_info *info[] =
{
   {
     I2C_BOARD_INFO("mydevice", 0xff),
   },
};

(...)

driver:
struct i2c_driver mydriver = {
     .driver = {
          .name = "mydevice",
     },
     .probe = myprobe,
     .remove = __exit_p(myremove),
};

got it ??

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
