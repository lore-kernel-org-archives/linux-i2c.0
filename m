From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] i2c: davinci: Avoid zero value of CLKH
Date: Tue, 24 Jul 2018 11:47:44 +0530
Message-ID: <8429ab76-28ef-eb82-2448-a0a50bd860ba@ti.com>
References: <20180713152017.2207-1-alexander.sverdlin@nokia.com>
 <20180723180722.7b46aw56oqxrwxwj@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180723180722.7b46aw56oqxrwxwj@ninjato>
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
To: Wolfram Sang <wsa@the-dreams.de>, Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 23 July 2018 11:37 PM, Wolfram Sang wrote:
> On Fri, Jul 13, 2018 at 05:20:17PM +0200, Alexander Sverdlin wrote:
>> If CLKH is set to 0 I2C clock is not generated at all, so avoid this value
>> and stretch the clock in this case.
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Applied to for-current, thanks!
> 
> I did not add stable because Alexander told me this is very likely not
> to be observed on HW out there. But TI people are investigating more.
> I suggest they resend this patch to stable if they see fit. D'accord
> everyone?

Sounds good to me.

Thanks,
Sekhar
