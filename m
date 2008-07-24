From: "Felipe Balbi" <felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: New Style I2C Driver : how to get clients ?
Date: Thu, 24 Jul 2008 21:28:09 +0300
Message-ID: <31e679430807241128g1ffe15c8u45cdaa3f2d990c95@mail.gmail.com>
References: <1216903949.48887b0dd2039@imp.free.fr>
	<31e679430807240616n4bed86c7sa5c5ce69e066d0b5@mail.gmail.com>
	<1216909598.4888911eb6cea@imp.free.fr>
	<1216915913.4888a9c91fc42@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1216915913.4888a9c91fc42-HZaT1/I6gcdWj0EZb7rXcA@public.gmane.org>
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

On Thu, Jul 24, 2008 at 7:11 PM,  <fuhz-GANU6spQydw@public.gmane.org> wrote:
> - Board init step #1
> - I2C bus platform_driver initialisation
>
> - Board init step #2 (register hardware i2c busses to the platform_driver)
> - The I2C bus platform_driver register the new adapters to I2C layer
>
> - Board init step #3 (register hardware devices present on each I2C bus)

are you writing a client driver or a bus driver ?

-- 
Best Regards,

Felipe Balbi
felipebalbi-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
