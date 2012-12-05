From: Peter Huewe <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Subject: I2C and devicetrees
Date: Wed, 5 Dec 2012 23:36:24 +0100
Message-ID: <201212052336.24233.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I have a short question about the relations between i2c and devicetrees.

I was wondering 
is the device part of the compatible string of a (trivial) i2c device 
instanciated via devicetree _always_ identical to name in i2c_client.name ?
Or can it be somehow different?

Here's a short example:
device tree:
test {
        compatible = "vendor,device1", "vendor,device2";
        reg = <0x20>;
}

The driver has in its id table only this entry:
static const struct i2c_device_id my_i2c_table[] = {
        {"device2", 0},
        {},
};

-> "vendor,device2" matches and the driver is called.
--> Is i2c_client.name guaranteed to be "device2" ?







Second question:
Where would you probably add an i2c tpm? 
Would you add it to
 Documentation/devicetree/bindings/i2c/trivial-devices.txt
or if it's not trivial add it to a new file under
 Documentation/devicetree/bindings/i2c/

or create a new folder 
 Documentation/devicetree/bindings/tpm
as there probably are more i2c tpms to come in the near future.

I'd probably prefer the first one, whereas Google already uses the second 
option:
http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=history;f=Documentation/devicetree/bindings/tpm;hb=refs/heads/chromeos-3.4


Thanks,
PeterH
