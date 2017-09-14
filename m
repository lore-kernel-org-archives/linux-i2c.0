From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v4 3/5] i2c: i2c-stm32f7: add driver
Date: Thu, 14 Sep 2017 17:52:57 +0200
Message-ID: <f5a75bff-7434-ec32-730f-daa1fbcd61a2@st.com>
References: <1505399319-14782-1-git-send-email-pierre-yves.mordret@st.com>
 <1505399319-14782-4-git-send-email-pierre-yves.mordret@st.com>
 <20170914154033.gkovgxgjbghtqmre@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170914154033.gkovgxgjbghtqmre@ninjato>
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
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 09/14/2017 05:40 PM, Wolfram Sang wrote:
> On Thu, Sep 14, 2017 at 04:28:37PM +0200, Pierre-Yves MORDRET wrote:
>> This patch adds initial support for the STM32F7 I2C controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> 
> Thanks for the quick update. I'd think the 'rate_max' variable can now
> be dropped and replaced by 'rate'? If so, we can fix that later
> incrementally.

Many thanks. I will try to put a reminder in my mind for this ;)

> 
> Applied to for-next (will be in 4.14), thanks! The DTS patches need to
> go via arm-soc.
> 

Thanks again !
