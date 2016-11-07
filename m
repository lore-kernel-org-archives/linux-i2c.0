From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv7 09/11] mfd: 88pm860x: Move over to new I2C device
 .probe() call
Date: Mon, 7 Nov 2016 16:13:04 -0300
Message-ID: <b30c575e-5e6e-6f20-6784-5e0fdd2fc902@osg.samsung.com>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-10-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478522866-29620-10-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Hello Kieran,

On 11/07/2016 09:47 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> As part of an effort to rid the mostly unused second parameter for I2C
> related .probe() functions and to conform to other existing frameworks
> we're moving over to a temporary replacement .probe() call-back.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
