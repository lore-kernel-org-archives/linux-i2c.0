From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 1/2] Convert i2c-mpc from a platform driver into a
	of_platform driver, V4
Date: Thu, 10 Jul 2008 12:36:58 -0400
Message-ID: <8EAD138A-6CE4-4AC7-BCBF-13B8E7C24CF1@freescale.com>
References: <20080630230126.12482.87927.stgit@terra>
	<fa686aa40807091022q22f6be99j89f311780bd3d369@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <fa686aa40807091022q22f6be99j89f311780bd3d369-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Jul 9, 2008, at 1:22 PM, Grant Likely wrote:

> On Mon, Jun 30, 2008 at 5:01 PM, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Convert i2c-mpc to an of_platform driver. Utilize the code in  
>> drivers/of-i2c.c to make i2c modules dynamically loadable by the  
>> device tree.
>
> Timur, can you please test this one on an 83xx platform?  It works on
> 5200, but I want to make sure 83xx doesn't break before I pick it up.

I'm on vacation this week, so I'll have to deal with it next week,  
after I've handled higher-priority issues.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
