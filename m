From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Add Imagination Technologies I2C SCB driver
Date: Tue, 4 Nov 2014 17:30:59 -0300
Message-ID: <54593783.8000703@imgtec.com>
References: <1414612641-4259-1-git-send-email-ezequiel.garcia@imgtec.com>	<1414612641-4259-2-git-send-email-ezequiel.garcia@imgtec.com> <CAL1qeaEquLhpuSXd5=t9oEXi2iOArDbFFbfVrhOmyu70GR-z7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL1qeaEquLhpuSXd5=t9oEXi2iOArDbFFbfVrhOmyu70GR-z7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Andrew,

On 10/31/2014 06:17 PM, Andrew Bresticker wrote:
>> From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>>
>> Add support for the IMG I2C Serial Control Bus (SCB) found on the
>> Pistachio and TZ1090 SoCs.
>>
>> Signed-off-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>> [Ezequiel: code cleaning and rebasing]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> Looks mostly good.  A few comments below.
> 

Thanks for all the feedback. I'm sending a v2 addressing all your comments.
-- 
Ezequiel
