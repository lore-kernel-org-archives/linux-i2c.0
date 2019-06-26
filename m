From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Add disable runtime pm quirk
Date: Wed, 26 Jun 2019 09:27:27 +0300
Message-ID: <5c14537d-b6aa-b478-fdd8-29f690b15e07@linux.intel.com>
References: <20190625083051.30332-1-acelan.kao@canonical.com>
 <a3469010-829c-16dc-be83-6fe9b3021530@linux.intel.com>
 <CAFv23QnaKMs9bjS9ry_L4K7wskUqNR2AsgDG-v+fah2XO7EpKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFv23QnaKMs9bjS9ry_L4K7wskUqNR2AsgDG-v+fah2XO7EpKw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: AceLan Kao <acelan.kao@canonical.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 6/26/19 5:32 AM, AceLan Kao wrote:
> Adding I2C_HID_QUIRK_NO_RUNTIME_PM quirk doesn't help on this issue.
> Actually, Goodix touchpad already has that PM quirk in the list for other issue.
>          { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
> I also modify the code as you suggested, but no luck.
> 
Yeah, I realized it won't help as the i2c-hid device is anyway powered 
on constantly when the device is open by the pm_runtime_get_sync() call 
in i2c_hid_open().

> It's not Goodix takes time to wakeup, it's designware I2C controller.
> Designware doesn't do anything wrong here, it's Goodix set the interrupt timeout
> that leads to the issue, so we have to prevent designware from runtime
> suspended.
> But only on that bus where Goodix is connected and open by user space. 
What I mean something like below:

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c 
b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90164fed08d3..bbeaa39ddc23 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -795,6 +795,9 @@ static int i2c_hid_open(struct hid_device *hid)
  	struct i2c_hid *ihid = i2c_get_clientdata(client);
  	int ret = 0;

+	/* some quirk test here */
+	pm_runtime_get_sync(&client->adapter->dev);
+
  	ret = pm_runtime_get_sync(&client->dev);
  	if (ret < 0)
  		return ret;
@@ -812,6 +815,9 @@ static void i2c_hid_close(struct hid_device *hid)

  	/* Save some power */
  	pm_runtime_put(&client->dev);
+
+	/* some quirk test here */
+	pm_runtime_put(&client->adapter->dev);
  }

  static int i2c_hid_power(struct hid_device *hid, int lvl)

-- 
Jarkko
