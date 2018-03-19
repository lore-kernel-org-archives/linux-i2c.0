From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
Date: Mon, 19 Mar 2018 09:51:07 +0100
Message-ID: <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
 <20180317204720.mclh4jw5owobbtww@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180317204720.mclh4jw5owobbtww@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Yes. Recovery mechanism is triggered whenever a busy line is detected.
This busy state can be checked by sw when either SDA or SCL is low: a bit is set
by Hw for this purpose.
On busy state I2C is reconfigured and lines are released the time of recovery.

Regards
On 03/17/2018 09:47 PM, Wolfram Sang wrote:
> On Mon, Mar 12, 2018 at 11:53:43AM +0100, Pierre-Yves MORDRET wrote:
>> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
>> and releases SCL/SDA signals but preserves I2C registers.
> 
> Does it release SDA when held down by the slave? Because that is what
> the recovery mechanism is for.
> 
