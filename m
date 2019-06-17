From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2] i2c: i2c-stm32f7: fix the get_irq error cases
Date: Mon, 17 Jun 2019 09:54:31 +0200
Message-ID: <b1fb50c0-b5ee-dd73-0b8e-f025dd843cbe@st.com>
References: <1558020594-1498-1-git-send-email-fabrice.gasnier@st.com>
 <20190614205322.GA17899@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190614205322.GA17899@ninjato>
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
Cc: alexandre.torgue@st.com, pierre-yves.mordret@st.com, marc.w.gonzalez@free.fr, linux-kernel@vger.kernel.org, fabien.dessenne@st.com, linux-i2c@vger.kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On 6/14/19 10:53 PM, Wolfram Sang wrote:
> Hi Fabrice,
> 
>> +		return irq_event ? irq_event : -ENODEV;
> 
> Maybe -ENOENT instead of -ENODEV? I mean you have a dev_err there, so
> the driver core should probably also complain?
> 
> You could also shorten the ternary operator to:
> 
> 	return irq_event ? : -E<whatyouprefer>;
> 
> However, both are minor nits. If you prefer to keep the patch as is,
> fine with me.

Hi Wolfram,

Thanks for reviewing,
I've sent a v3 with your suggestions.

Regards,
Fabrice
> 
> Regards,
> 
>    Wolfram
> 
