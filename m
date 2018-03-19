From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [RESEND PATCH v1 2/6] i2c: i2c-stm32f7: Add slave support
Date: Mon, 19 Mar 2018 09:41:20 +0100
Message-ID: <5a3c5b21-bc66-ce73-a997-f686ecc275f3@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-3-git-send-email-pierre-yves.mordret@st.com>
 <20180317205109.gocf5wemtjkyomct@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180317205109.gocf5wemtjkyomct@ninjato>
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
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I do believe the hw can support it, even it looks odd to me having the same I2C
in slave and master mode at the same time.
Nevertheless the driver is devised to support either master or slave more but
not at the same time.

Regards
On 03/17/2018 09:51 PM, Wolfram Sang wrote:
> 
>> + * @master_mode: boolean to know in which mode the I2C is running (master or
>> + * slave)
> 
> It can't do both at the same time?
> 
