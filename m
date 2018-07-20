From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] i2c: davinci: Avoid zero value of CLKH
Date: Fri, 20 Jul 2018 13:43:46 -0500
Message-ID: <0c29ccf5-4077-47a2-e7e0-c89ffcf8cb0b@ti.com>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
 <ab965f1d-de6c-75f7-9ebd-35d31ed3de18@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ab965f1d-de6c-75f7-9ebd-35d31ed3de18@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sekhar Nori <nsekhar@ti.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>, linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>
List-Id: linux-i2c@vger.kernel.org



On 07/17/2018 06:57 AM, Sekhar Nori wrote:
> On Friday 13 July 2018 08:50 PM, Alexander Sverdlin wrote:
>> If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
>> and stretch the clock in this case.
> 
> This must be by observation since specification does not seem to state
> this.

It will be good to know (mention) on what hw was it observed?

> 
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> In any case, the patch is fine.
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
[...]

-- 
regards,
-grygorii
