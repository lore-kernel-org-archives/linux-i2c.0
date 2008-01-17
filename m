From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-au1550: properly terminate zero-byte
	transfers
Date: Thu, 17 Jan 2008 17:37:33 +0100
Message-ID: <20080117163733.GA13110@roarinelk.homelinux.net>
References: <20080114084652.GA15392@roarinelk.homelinux.net>
	<20080117165230.711e87bf@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080117165230.711e87bf-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, cd-8pe3aW1LYQvVtiohHAVwjA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 17, 2008 at 04:52:30PM +0100, Jean Delvare wrote:
> Hi Manuel,
> 
> This approach looks much nicer than your previous proposal. I like it.
> Applied, thanks!

Thank you, however there's still the problem with unterminated bus xfers
after receiving a NAK. I've only seen them with a PCA9539 if one's trying
to access a non-existant register.  However it can't be solved to everyones
satisfaction I'm afraid...
(see http://mlau.at/files/i2c-au1550-stopfix-1-behav_2.png )

-- 
 Manuel Lauss

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
