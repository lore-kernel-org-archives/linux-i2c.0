From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
Date: Fri, 29 Apr 2016 15:03:51 +0100
Message-ID: <20160429140351.GA1459@griffinp-mac>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
 <20160424211044.GD4317@katana>
 <5722107C.3000600@st.com>
 <20160428145720.GA1541@katana>
 <572344D8.6060401@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <572344D8.6060401@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@gmail.com, patrice.chotard@st.com, lee.jones@linaro.org, linux-i2c@vger.kernel.org, Frederic Pillon <frederic.pillon@st.com>
List-Id: linux-i2c@vger.kernel.org

Hi Maxime,

On Fri, 29 Apr 2016, Maxime Coquelin wrote:

> 
> 
> On 04/28/2016 04:57 PM, Wolfram Sang wrote:
> >>The trick is to switch to SPI mode, 9 bits words and write a 0,
> >>so that 9 clock pulses are generated.
> >Heh. As long as it works :) But as you said, it really needs a comment.
> >
> :)
> I didn't faced the problem myself, but it looks good with an oscilloscope,
> and a customer reported it to work.
> 
> Peter, will you resend with adding the explanations I provided as comment?
>
Yes I'll send a v2 with your comment added.

Peter
