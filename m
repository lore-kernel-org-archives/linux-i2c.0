From: Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [RESEND PATCH v1 6/6] i2c: i2c-stm32f7: Implement I2C recovery
 mechanism
Date: Tue, 20 Mar 2018 10:45:09 +0100
Message-ID: <4a1aa386-21dc-12a2-b2b5-6e25586ffc79@st.com>
References: <1520852023-27083-1-git-send-email-pierre-yves.mordret@st.com>
 <1520852023-27083-7-git-send-email-pierre-yves.mordret@st.com>
 <20180317204720.mclh4jw5owobbtww@ninjato>
 <2672947b-46b2-7bd7-ac13-501db8bde72b@st.com>
 <fdc16b28-3aab-1d37-3c93-40ed371bfd4f@st.com>
 <20180320094216.ugietqyerdowq4c4@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180320094216.ugietqyerdowq4c4@katana>
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

Thanks for your quick answer

On 03/20/2018 10:42 AM, Wolfram Sang wrote:
> Hi,
> 
>> Looking at the recovery API, this recovery is for slave and nothing else with my
>> case. Therefore I think I have to get move this reset out of recovery API.
> 
> Yes, you are correct. You need a custom function, this is totally driver
> specific.

OK !
> 
>> Slave Recovery mechanism is another story to implement in our platform since we
>> have to deal with GPIOs.
> 
> For that, the recovery infrastructure in the core has lots of helpers
> for you.
> 
Yeah. This is what I saw nonetheless the main trouble is to setup SCL/SDA into
GPIO. Not that easy. but feasible of course.

BTW I will rework my driver.

Thanks.

> Regards,
> 
>    Wolfram
> 
