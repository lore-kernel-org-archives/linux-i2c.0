From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 5/8] i2c: Export i2c_match_id() for direct use by device
 drivers
Date: Tue, 10 May 2016 01:02:52 -0400
Message-ID: <dd0774b1-116f-45fe-87bb-a244de5844e7@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-6-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462374888-22888-6-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On 05/04/2016 11:14 AM, Kieran Bingham wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> When there was no other way to match a I2C device to driver i2c_match_id()
> was exclusively used.  However, now there are other types of tables which
> are commonly supplied, matching on an i2c_device_id table is used less
> frequently.  Instead of _always_ calling i2c_match_id() from within the
> framework, we only need to do so from drivers which have no other way of
> matching.  This patch makes i2c_match_id() available to the aforementioned
> device drivers.
> 
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
> Tested-by: Kieran Bingham <kieran@bingham.xyz>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
