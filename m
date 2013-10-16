From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: Fix modalias for ACPI enumerated I2C devices
Date: Wed, 16 Oct 2013 10:16:29 +0300
Message-ID: <525E3D4D.1040102@linux.intel.com>
References: <1381414669-26115-1-git-send-email-jarkko.nikula@linux.intel.com> <3125784.Lc8ATpWH6J@vostro.rjw.lan> <20131015233143.GA28114@kroah.com> <2766730.3Wpbhyx1zD@vostro.rjw.lan> <CACxGe6v3JHLKHqBXux=1mgm227S2dLafaqohKvzqsw1uo6tHyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CACxGe6v3JHLKHqBXux=1mgm227S2dLafaqohKvzqsw1uo6tHyA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <rob.herring@calxeda.com>, Zhang Rui <rui.zhang@intel.com>, Linux I2C <linux-i2c@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 10/16/2013 03:04 AM, Grant Likely wrote:
> On Wed, Oct 16, 2013 at 12:47 AM, Rafael J. Wysocki<rjw@sisk.pl>  wrote:
>> On Tuesday, October 15, 2013 04:31:43 PM Greg Kroah-Hartman wrote:
>>> On Tue, Oct 15, 2013 at 11:24:01PM +0200, Rafael J. Wysocki wrote:
>>>> On Tuesday, October 15, 2013 01:48:29 PM Greg Kroah-Hartman wrote:
>>>>> On Tue, Oct 15, 2013 at 10:37:02PM +0200, Rafael J. Wysocki wrote:
>>>>>> On Tuesday, October 15, 2013 07:44:44 PM Zhang Rui wrote:
>>>>>>> I have a question about the device "uevent" and "modalias" sysfs
>>>>>>> attributes.
>>>>>>> what is the relationship between these two?
>>>>>>> Am I right to say that, if there is the "MODALIAS" field in uevent file,
>>>>>>> this field must be consistent with the content in "modalias" attribute?
>>>>> Well, if it isn't, it's pretty pointless, right?
>>>>>>> static int platform_uevent(struct device *dev, struct kobj_uevent_env
>>>>>>> *env)
>>>>>>> {
>>>>>>>          struct platform_device  *pdev = to_platform_device(dev);
>>>>>>>          int rc;
>>>>>>>
>>>>>>>          /* Some devices have extra OF data and an OF-style MODALIAS */
>>>>>>>          rc = of_device_uevent_modalias(dev, env);
>>>>>>>          if (rc != -ENODEV)
>>>>>>>                  return rc;
>>>>>>>
>>>>>>>          add_uevent_var(env, "MODALIAS=%s%s", PLATFORM_MODULE_PREFIX,
>>>>>>>                          pdev->name);
>>>>>>>          return 0;
>>>>>>> }
>>>>>>>
>>>>>>> This means that the OF-style MODALIAS is not shown in "modalias" sysfs
>>>>>>> attribute.
>>>>>>> is this a bug?
Here is an example from one DT based system:

cat /sys/bus/platform/devices/48070000.i2c/uevent
DRIVER=omap_i2c
OF_NAME=i2c
OF_FULLNAME=/ocp/i2c@48070000
OF_COMPATIBLE_0=ti,omap4-i2c
OF_COMPATIBLE_N=1
MODALIAS=of:Ni2cT<NULL>Cti,omap4-i2c

cat /sys/bus/platform/devices/48070000.i2c/modalias
platform:48070000.i2c

And a device on that I2C bus:

cat /sys/bus/platform/devices/rtc.11/uevent
DRIVER=twl_rtc
OF_NAME=rtc
OF_FULLNAME=/ocp/i2c@48070000/twl@48/rtc
OF_COMPATIBLE_0=ti,twl4030-rtc
OF_COMPATIBLE_N=1
MODALIAS=of:NrtcT<NULL>Cti,twl4030-rtc

cat /sys/bus/platform/devices/rtc.11/modalias
platform:rtc.11

Unfortunately I cannot debug above example further at the moment is 
there failing or needless modprobe calls. Maybe device tree experts know 
better?

-- 
Jarkko

