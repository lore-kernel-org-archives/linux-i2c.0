From: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH V3] I2C driver for IMX
Date: Thu, 10 Apr 2008 05:09:13 -0500
Message-ID: <43AD241A-064B-4140-8D9F-07D0F102DDEA@kernel.crashing.org>
References: <ftf8ud$pl6$1@ger.gmane.org>
	<20080409232834.GG1197@trinity.fluff.org>
	<Pine.LNX.4.64.0804092223540.10428@gate.crashing.org>
	<20080410120141.4d220d27@hyperion.delvare>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080410120141.4d220d27-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-arm-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


On Apr 10, 2008, at 5:01 AM, Jean Delvare wrote:
> On Wed, 9 Apr 2008 22:25:39 -0500 (CDT), Kumar Gala wrote:
>>
>> On Thu, 10 Apr 2008, Ben Dooks wrote:
>>
>>> On Tue, Apr 08, 2008 at 11:01:25AM +0300, Darius wrote:
>>>> changes:
>>>> 1. Removed hardcoded constants
>>>> 2. Fixed bug in chip hardware
>>>> 3. Added i2c device for mx1ads
>>>>
>>>> Tested with mx1ads v2.0 board and LCD on I2C interface driver
>>>>
>>>> Signed-off-by: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>> ---
>>>
>>> Hmm, this hasn't appeared on the i2c list where it should be being
>>> reviewed before submission. Not bothered to look or snip the rest.
>>
>> looking at this it seems the HW is identical to the driver handled by
>> i2c-mpc.c.  (which is used on Motorola and now Freescale PPC chips).
>
> Then I guess that we want to add support to the i2c-mpc driver rather
> than adding another driver to the kernel tree?

that would be my opinion.

- k

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
