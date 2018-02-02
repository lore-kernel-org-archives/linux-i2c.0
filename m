From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 0/2] I2C-DaVinci: Adjustments for davinci_i2c_probe()
Date: Fri, 2 Feb 2018 11:24:47 -0600
Message-ID: <310d5f2c-3a8d-80e3-a185-21da933d107f@ti.com>
References: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
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
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



On 02/02/2018 11:20 AM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 2 Feb 2018 18:16:14 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>    Delete an error message for a failed memory allocation
>    Improve a size determination
> 
>   drivers/i2c/busses/i2c-davinci.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
