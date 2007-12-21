From: Vitaly Bordug <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH POWERPC] i2c: adds support for i2c bus on Frescale
 CPM1/CPM2 controllers
Date: Sat, 22 Dec 2007 00:11:12 +0300
Message-ID: <20071222001112.691b80c8@kernel.crashing.org>
References: <476C15BC.3090807@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <476C15BC.3090807-NIgtFMG+Po8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 21 Dec 2007 20:36:28 +0100
Jochen Friedrich wrote:

> Using the port of 2.4 code from Vitaly Bordug
> <vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org> and the actual algorithm used by the i2c
> driver of the DBox code on cvs.tuxboc.org from Tmbinc, Gillem
> (htoa-hi6Y0CQ0nG0@public.gmane.org). Renamed i2c-rpx.c and i2c-algo-8xx.c to i2c-cpm.c and
> converted the driver to an of_platform_driver.
> 

I had an attempt a while ago to do this but haven't had enough time to get it completed, so
I am glad to see it finally picked up. There was some sort of discussion that time, you seem to have some of those points
addressed but  something not, please
check: http://lkml.org/lkml/2007/5/8/45

(for instance, cpm_i2c_shutdown() and i2c_cpm_del_bus() are void because they cant' fail) 

Also, why this was directed to Scott? This is lm-sensors stuff and is
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> material...

-- 
Sincerely, Vitaly
