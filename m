From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
Date: Tue, 20 Mar 2018 10:31:49 +0100
Message-ID: <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
 <20180317204720.mclh4jw5owobbtww@ninjato>
 <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
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

Hi Wolfram,

I do believe there is a misunderstanding of this recovery mechanism at my end.
I intends to solve a problem where my I2C was stall but not the slave.
Thus if bus is busy I reset the IP.

Looking at the recovery API, this recovery is for slave and nothing else with my
case. Therefore I think I have to get move this reset out of recovery API.
Please correct me whether I'm wrong

Slave Recovery mechanism is another story to implement in our platform since we
have to deal with GPIOs.

Let me know
Regards

On 03/19/2018 09:51 AM, Pierre Yves MORDRET wrote:
> Yes. Recovery mechanism is triggered whenever a busy line is detected.
> This busy state can be checked by sw when either SDA or SCL is low: a bit is set
> by Hw for this purpose.
> On busy state I2C is reconfigured and lines are released the time of recovery.
> 
> Regards
> On 03/17/2018 09:47 PM, Wolfram Sang wrote:
>> On Mon, Mar 12, 2018 at 11:53:43AM +0100, Pierre-Yves MORDRET wrote:
>>> Feature prevents I2C lock-ups. Mechanism resets I2C state machine
>>> and releases SCL/SDA signals but preserves I2C registers.
>>
>> Does it release SDA when held down by the slave? Because that is what
>> the recovery mechanism is for.
>>
