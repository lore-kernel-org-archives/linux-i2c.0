From: srinivas kandagatla <srinivas.kandagatla@st.com>
Subject: Re: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
Date: Thu, 17 Oct 2013 15:30:48 +0100
Message-ID: <525FF498.3060202@st.com>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>
 <525FAEED.7030207@st.com> <20131017141957.GE14104@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131017141957.GE14104@ns203013.ovh.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@wwwdotorg.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Stephen GALLIMORE <stephen.gallimore@st.com>, Stuart MENEFY <stuart.menefy@st.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Lee Jones <lee.jones@linaro.org>, Gabriel FERNANDEZ <gabriel.fernandez@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime COQUELIN <maxime.coquelin@st.com>
List-Id: linux-i2c@vger.kernel.org

On 17/10/13 15:19, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:33 Thu 17 Oct     , srinivas kandagatla wrote:
>> On 17/10/13 08:27, Maxime COQUELIN wrote:
>>> ...
>>>>>>> +
>>>>>>> +static struct of_device_id st_i2c_match[] =3D {
>>>>>>> +     { .compatible =3D "st,comms-ssc-i2c", },
>>>>> the rules is to put the first soc that use the ip in the compatible
>>>>> as st,sti7100-scc-i2c
>>> Ok. There are no plans to upstream the SH4 platforms, it will only =

>>> remains in stlinux.com.
>>> Maybe I can set the first ARM platform (STiH415)?
>>> That would give st,stih415-ssc-i2c.
>> NAK, for st,stih415-ssc-i2c naming.
>>
>> IMO, this makes sense when the same IP integration done on different SOC
>> changes slightly/very differently.
>>
>> But in this case the "comms" IP remains unchanged across all the SOCs.
>>
>> I would still prefer "st,comms-ssc-i2c", allowing a single device driver
>> to match against several SoCs. ST "comms" IP it is integrated across all
>> the STi series of SoCs, so we don't want to add new entry in compatible
>> for every new SOC.
> =

> you never need this you always the first SoC that's all

Sorry to ask this but, Where is this requirement coming from?
I have not spotted any thing as such in ePAPR specs.


All the spec says is.
=3D=3D=3D
The compatible property value consists of one or more strings that
define the specific programming model for the device. This list of
strings should be used by a client program for device driver selection.
The property value consists of a concatenated list of null terminated
strings, *from most specific to most general.* They allow a device to
express its compatibility with a family of similar devices, potentially
allowing a single device driver to match against several devices.
The recommended format is =93manufacturer,model=94, where manufacturer is a
string describing the name of the manufacturer (such as an OUI), and
model specifies the model number.

Example:
compatible =3D =93fsl,mpc8641-uart=94, =93ns16550";
In this example, an operating system would first try to locate a device
driver that supported fsl,mpc8641-uart. If a driver was not found, it
would then try to locate a driver that supported the more general
ns16550 device type.
=3D=3D=3D

The more general compatible string in this case is "st,comms-ssc-i2c",
rather than the first soc name.
How can a first SOC name be more general?

As this driver is not very specific to StiH415, it is generic driver for
ST comms-ssc-i2c block.

Thanks,
srini




> =

> see other bindings on at91 as example sorry NACK
> =

> Best Regards,
> J.
>>
>>
>> Thanks,
>> srini
>>
>>>
>>> Thanks for the review,
>>> Maxime
>>>
>>>>>
>>
> =

> =
