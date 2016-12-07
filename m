From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V1] rtc: ds1307: Add ACPI support
Date: Wed, 7 Dec 2016 17:16:02 +0100
Message-ID: <20161207161602.lbiii4usdcv6xq7f@piout.net>
References: <1480474651-13984-1-git-send-email-tnhuynh@apm.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCKYNX7Y3IMBBQ7LUDBAKGQEDSHOW5Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1480474651-13984-1-git-send-email-tnhuynh-qTEPVZfXA3Y@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Tin Huynh <tnhuynh-qTEPVZfXA3Y@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Thang Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 30/11/2016 at 09:57:31 +0700, Tin Huynh wrote :
> This patch enables ACPI support for rtc-ds1307 driver.
> 
> Signed-off-by: Tin Huynh <tnhuynh-qTEPVZfXA3Y@public.gmane.org>
> ---
>  drivers/rtc/rtc-ds1307.c |   51 ++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 43 insertions(+), 8 deletions(-)
> 
Applied after fixing a few alignment issues, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
