Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB53B19BF
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437466; cv=none; b=svJUsdc4uFZA0dcB/BEuU3pR3MOxULvUSR8lGQVEDGSBmfXo+ZDTWf6H81v8V4S4F8U3tZuRLoH0Q5vKZ7Fgl2X3UEAsIh31y5AxoY57Vhe9QcgSzmMKwpephNqsQuGIj7kox3EhcPTK1ZHFu3EDzgmzO70NpQxOOJOcED+colE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437466; c=relaxed/simple;
	bh=+/NGUHolB371uztG9XeCymTMB3WRK8yYZWDwG3LuMdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLpSpr8IjSEFvKeHH3DYaAkAsalxAnznNpMfrcTdSGgut11/5B37cB5Yyt88uKYCjL9YBPcAwLvORSAJpHHNwnZZ4xmoGBuBUZar/fME21mJmrh6RKeqO4cpj4QDbTY9VR6Tdy4KZKTFvePMgC4/aSpj+y5ZuRhhXdwXcJELEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl03+AX0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl03+AX0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f236418so2915886b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437463; x=1784042263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+qr0W4lvx3eBmXAXSSBSOT9CkmaDpcY2q3Ev2L5JMIE=;
        b=Hl03+AX0QDfkNwxvcfWbLiCz4wK0yy6u11gNnIrIVjMsN9GNX/0NW1RZ5VB0ki8Smc
         14kqLDEiAlD+uwbgiK6b4K5OBuMGnG+hfglKYhe11wFeWh1v8Kctrb499qUoiY7+4hXa
         BGxpn5XgxY78p7RVwksi2i4aYfHpls2R7kipXu4lrE7UzLx/+yU4vXabxohkhskczvVy
         G0icf3iipYvHk9M4+7jW464RSW5y1IdSbqo9D0bxCCGjoqaL+T7je9yTvkJzrBXkCQJM
         JOh6FToi96DwrEtCV43mzDO3wGjkzVafR+mORE/47iK01EEQEtG8UE0t8MWTqHpXCruD
         DdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437463; x=1784042263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+qr0W4lvx3eBmXAXSSBSOT9CkmaDpcY2q3Ev2L5JMIE=;
        b=DsR1LuMDXoS1WUYt8OIDpJrJoTdc5bDR5K506/+wjsAodVINlO9aqetDBKNW7dLb6F
         16OjcFkAWLHKt+NEYy2DbJ0EIwh8m5rZrgDKsv2td90J9ZKaiafi4OGq+YHI3QIdyIL9
         HgXdRXCKkCgPIW/mX1zySx4zt2g8eFxaaxDijHUMY5LYs8GUVKqbPrMfQRYb/K53ONBL
         wpCWIx/OQtzv5VA56K5WnRwumBx24AMw1vnJV+YOhm9kzHDYyP0dQ2LQCRZaOa4TaUyd
         v90WEaFvFn7G9Isv9yJv2T0HxpqI2HVC71Po4g9LY8aS/THSeOnysXRGloBluRBClzTE
         aL/g==
X-Forwarded-Encrypted: i=1; AHgh+RrQ9yROssClZpd8eXa6luoLCo/Bag+qF1xMp29a+h4pd3SCoPgxT4PxzD+io1pDEsEmDJMtB2q6PJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP4gdZU+LxoiAANa59CGn+o1YlbdL969Jr/p4WJZAqFR0t7tCk
	mmfdka9uA+vGNnVQIsiLbv3yLxfp2zFyxHEdvAHDJ+NfKp9QYhR6RZJI
X-Gm-Gg: AfdE7clGv/rqt60xR1stqZb0I3g81kzbLqV1BQCJOtAcExi466KyHzJH8RS93Ap4VjP
	uFySdhY+DB6smDHZDtfkEVUIjdRBRIymTrgko8f1VNO+U4oSTg4MPYHSsHIi1aVdUCxDuQgxK03
	RLJvNa8BPXHUpeQoMOw7Kav6RrDPhvAXGejnym656lWG5U2AU5Q3hdZb3xOcX7Zz1GOalLtaJxF
	P7lPtQxi2Bzjk094cwubw92jp6wVTTBuqan8SdKMDXQd6HJ+1TSMtQFhdntvYSbDpjv0s4WS/pE
	p2AfQ7ivz0h2Aeif2AaYJIXH/KOicy0vbu9aE6hUEX0HecAm48EdO7xNRsLxvcU05ghhR/QOsB6
	Zn4BC0mDaDGa4IqKP8iH/UsxPTJR0abIb1HQUHKphf1cjZSQE+oGq5UvJPLtBb4XfElqZ/J2jWZ
	Qn7aNDVr10lTY2awbiHQl7rLbj3MgUEjdQj84vOxNaQZWa2iyBtx+wF/+LNmfDvtCqqA==
X-Received: by 2002:a05:6a00:9469:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-8482eacc43bmr2768535b3a.13.1783437463249;
        Tue, 07 Jul 2026 08:17:43 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2003:63bf:6d1c:a790:1205:96eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm5724397b3a.28.2026.07.07.08.17.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Jul 2026 08:17:42 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	andi.shyti@kernel.org,
	wsa+renesas@sang-engineering.com,
	ojeda@kernel.org,
	dakr@kernel.org,
	igor.korotin@linux.dev,
	branstj@gmail.com,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v4 2/3] rust: add minimal IIO subsystem abstractions
Date: Tue,  7 Jul 2026 22:15:41 +0700
Message-ID: <20260707151542.91997-3-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem:

- IioVal enum with NonZeroI32 for division-by-zero prevention on
  IIO_VAL_FRACTIONAL
- IioDriver trait with read_raw callback (requires Send + Sync)
- Device<T, State> with typestate (Unregistered -> Registered) to
  prevent double-registration at compile time
- PinnedDrop for guaranteed cleanup: iio_device_unregister ->
  drop_in_place(T) -> iio_device_free
- Compile-time const VTABLE (iio_info)
- C-to-Rust FFI trampoline for read_raw dispatch

The abstraction uses iio_device_alloc (not devm_*) so that the Rust
Drop implementation has full control over the cleanup sequence.
Module ownership is enforced via __iio_device_register(indio_dev, module).

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/error.rs            |   1 +
 rust/kernel/iio.rs              | 293 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 4 files changed, 298 insertions(+)
 create mode 100644 rust/kernel/iio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 446dbeaf0866..1ff262063556 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -61,6 +61,8 @@
 #include <linux/firmware.h>
 #include <linux/fs.h>
 #include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/ioport.h>
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index a56ba6309594..5dc917d92151 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -86,6 +86,7 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ENODATA, "No data available.");
 }
 
 /// Generic integer kernel error.
diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
new file mode 100644
index 000000000000..816bf370df86
--- /dev/null
+++ b/rust/kernel/iio.rs
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+//! IIO subsystem abstractions.
+//!
+//! Minimal safe Rust wrappers for the Linux IIO (Industrial I/O) subsystem.
+//! Provides [`Device`] for allocating and registering an IIO device, and the
+//! [`IioDriver`] trait for implementing `read_raw` callbacks in safe Rust.
+
+use crate::{
+    bindings::{
+        __iio_device_register,
+        iio_chan_spec,
+        iio_dev,
+        iio_device_alloc,
+        iio_device_free,
+        iio_device_unregister,
+        iio_info,
+        INDIO_DIRECT_MODE, //
+    },
+    device,
+    error::{
+        code::*,
+        to_result,
+        Result, //
+    },
+    prelude::*,
+    ThisModule, //
+};
+use core::{
+    ffi::c_int,
+    marker::PhantomData,
+    mem::{
+        forget,
+        size_of,
+        zeroed, //
+    },
+    num::NonZeroI32,
+    pin::Pin,
+    ptr::drop_in_place, //
+};
+
+use pin_init::{pin_data, pinned_drop};
+
+/// IIO value type: single integer (`IIO_VAL_INT`).
+pub const IIO_VAL_INT: c_int = crate::bindings::IIO_VAL_INT as c_int;
+/// IIO value type: integer plus micro part (`IIO_VAL_INT_PLUS_MICRO`).
+pub const IIO_VAL_INT_PLUS_MICRO: c_int = crate::bindings::IIO_VAL_INT_PLUS_MICRO as c_int;
+/// IIO value type: integer plus nano part (`IIO_VAL_INT_PLUS_NANO`).
+pub const IIO_VAL_INT_PLUS_NANO: c_int = crate::bindings::IIO_VAL_INT_PLUS_NANO as c_int;
+/// IIO value type: fractional (`IIO_VAL_FRACTIONAL`).
+pub const IIO_VAL_FRACTIONAL: c_int = crate::bindings::IIO_VAL_FRACTIONAL as c_int;
+
+/// Represents the return value of a `read_raw` operation.
+///
+/// Each variant corresponds to an `IIO_VAL_*` constant and tells the
+/// IIO core how to format `val` and `val2` for userspace.
+pub enum IioVal {
+    /// A single integer value.
+    Int(i32),
+    /// A fractional value represented as `val / val2`.
+    /// The denominator is `NonZeroI32` to prevent division-by-zero in
+    /// `iio_format_value()`.
+    Fractional(i32, NonZeroI32),
+    /// An integer plus a micro (1e-6) fractional part: `val.val2`.
+    IntPlusMicro(i32, i32),
+    /// An integer plus a nano (1e-9) fractional part: `val.val2`.
+    IntPlusNano(i32, i32),
+}
+
+/// Trait to be implemented by IIO driver private data.
+///
+/// Implementors supply the `read_raw` callback invoked by the IIO core
+/// when userspace reads a channel attribute (e.g. `in_angl_raw`).
+///
+/// The `Send + Sync` bounds ensure the compiler rejects driver types with
+/// thread-unsafe interior mutability (e.g. `Cell`), since the IIO core may
+/// invoke `read_raw` concurrently from multiple sysfs readers.
+pub trait IioDriver: Send + Sync {
+    /// Called by the IIO core when userspace reads a channel attribute.
+    ///
+    /// `chan` is the channel being read; `mask` selects the attribute
+    /// (e.g. `IIO_CHAN_INFO_RAW`, `IIO_CHAN_INFO_SCALE`).
+    fn read_raw(&self, chan: *const iio_chan_spec, mask: isize) -> Result<IioVal>;
+
+    /// Returns the channel specifications for this driver.
+    ///
+    /// The default implementation returns an empty slice.
+    fn channels(&self) -> &[iio_chan_spec] {
+        &[]
+    }
+}
+
+/// C-compatible trampoline for the `iio_info.read_raw` callback.
+///
+/// # Safety
+///
+/// This function is only called by the IIO core with valid pointers:
+/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`.
+/// - `chan` points to a valid channel spec from the device's channel array.
+/// - `val` and `val2` are valid pointers for writing the result.
+unsafe extern "C" fn read_raw_callback<T: IioDriver>(
+    indio_dev: *mut iio_dev,
+    chan: *const iio_chan_spec,
+    val: *mut c_int,
+    val2: *mut c_int,
+    mask: isize,
+) -> c_int {
+    // SAFETY: `indio_dev` is valid and was allocated with space for `T` in its
+    // private data area. The `priv_` field was initialized in `Device::build_device()`.
+    let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
+    // SAFETY: `priv_ptr` points to a valid, initialized instance of `T` that
+    // lives as long as the `iio_dev` allocation.
+    let driver = unsafe { &*priv_ptr };
+
+    match driver.read_raw(chan, mask) {
+        Ok(IioVal::Int(v)) => {
+            // SAFETY: `val` is a valid pointer provided by the IIO core.
+            unsafe {
+                *val = v;
+            }
+            IIO_VAL_INT
+        }
+        Ok(IioVal::Fractional(v, v2)) => {
+            // SAFETY: `val` and `val2` are valid pointers provided by the IIO core.
+            unsafe {
+                *val = v;
+                *val2 = v2.get();
+            }
+            IIO_VAL_FRACTIONAL
+        }
+        Ok(IioVal::IntPlusMicro(v, v2)) => {
+            // SAFETY: `val` and `val2` are valid pointers provided by the IIO core.
+            unsafe {
+                *val = v;
+                *val2 = v2;
+            }
+            IIO_VAL_INT_PLUS_MICRO
+        }
+        Ok(IioVal::IntPlusNano(v, v2)) => {
+            // SAFETY: `val` and `val2` are valid pointers provided by the IIO core.
+            unsafe {
+                *val = v;
+                *val2 = v2;
+            }
+            IIO_VAL_INT_PLUS_NANO
+        }
+        Err(e) => e.to_errno(),
+    }
+}
+
+// Device<T, State>: IIO device wrapper with typestate.
+
+/// Marker type for an unregistered IIO device.
+pub struct Unregistered;
+/// Marker type for a registered IIO device.
+pub struct Registered;
+
+/// A wrapped IIO device managing its C `struct iio_dev` lifetime.
+///
+/// Uses `iio_device_alloc` for allocation (no devres involvement) and
+/// manual cleanup via `Drop`: `iio_device_unregister` -> `drop_in_place`
+/// for `T` -> `iio_device_free`.
+#[pin_data(PinnedDrop)]
+pub struct Device<T: IioDriver, State = Unregistered> {
+    indio_dev: *mut iio_dev,
+    registered: bool,
+    _p: PhantomData<(T, State)>,
+}
+
+// SAFETY: `Device` only contains a raw pointer to a kernel-managed `iio_dev`.
+// The IIO core serializes access to the device, and `T` is required to be `Send`.
+unsafe impl<T: IioDriver, S> Send for Device<T, S> {}
+// SAFETY: All `&self` access to the `iio_dev` is read-only or goes through the
+// IIO core which provides its own synchronization. `T` is required to be `Sync`.
+unsafe impl<T: IioDriver, S> Sync for Device<T, S> {}
+
+#[pinned_drop]
+impl<T: IioDriver, S> PinnedDrop for Device<T, S> {
+    fn drop(self: Pin<&mut Self>) {
+        if self.registered {
+            // SAFETY: The device was successfully registered via
+            // `__iio_device_register`. Unregistering drains all pending
+            // callbacks, ensuring no `read_raw` is in flight after this.
+            unsafe { iio_device_unregister(self.indio_dev) };
+        }
+
+        // SAFETY: `priv_` was fully initialized in `build_device` via
+        // `init.__pinned_init(priv_ptr)`. `drop_in_place` runs `T`'s destructor
+        // (including any pinned fields like Mutex). After that, `iio_device_free`
+        // calls `put_device` which decrements the kref. The underlying `iio_dev`
+        // memory is only freed when kref reaches 0.
+        unsafe {
+            let priv_ptr = (*self.indio_dev).priv_ as *mut T;
+            drop_in_place(priv_ptr);
+            iio_device_free(self.indio_dev);
+        }
+    }
+}
+
+impl<T: IioDriver> Device<T> {
+    // SAFETY: The remaining fields of `iio_info` are pointers and function
+    // pointers. Zeroed values are NULL, and the IIO core checks for NULL
+    // before invoking callbacks or dereferencing attribute group pointers.
+    const VTABLE: iio_info = iio_info {
+        read_raw: Some(read_raw_callback::<T>),
+        ..unsafe { zeroed() }
+    };
+
+    /// Allocates a new IIO device with the given driver data.
+    ///
+    /// Uses `iio_device_alloc` (not `devm_*`) so that the Rust `Drop`
+    /// implementation has full control over the cleanup sequence.
+    /// The device is not yet registered; call [`register`](Self::register)
+    /// to make it visible to userspace.
+    pub fn build_device<E>(
+        dev: &device::Device,
+        name: &'static CStr,
+        init: impl PinInit<T, E>,
+    ) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        let priv_size = i32::try_from(size_of::<T>()).map_err(|_| EINVAL)?;
+
+        // SAFETY: `dev.as_raw()` returns a valid `struct device` pointer.
+        // `iio_device_alloc` allocates an `iio_dev` with `sizeof(T)` bytes of
+        // private data. Returns NULL on failure.
+        let indio_dev = unsafe { iio_device_alloc(dev.as_raw(), priv_size) };
+        if indio_dev.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: `indio_dev` is valid and freshly allocated. `priv_` points to
+        // zeroed memory (kzalloc'd by iio_device_alloc). `PinInit::__pinned_init`
+        // overwrites it in place without reading previous contents.
+        let priv_ptr = unsafe { (*indio_dev).priv_ as *mut T };
+        let init_result = unsafe { init.__pinned_init(priv_ptr) };
+        if let Err(e) = init_result {
+            // SAFETY: `pin_init` guarantees partial-init rollback internally.
+            // `priv_` memory was not fully initialized, so we only free the
+            // container without running `T`'s destructor.
+            unsafe { iio_device_free(indio_dev) };
+            return Err(Error::from(e));
+        }
+
+        // SAFETY: `priv_ptr` is now fully initialized. We set up the IIO
+        // device fields:
+        // - `name` is a `'static` C string that outlives the device.
+        // - `VTABLE` is a `'static` const and outlives the device.
+        // - `channels()` returns a reference to data owned by `T` in `priv_`,
+        //   which remains at a fixed address because `priv_` is heap-allocated
+        //   inside `iio_dev`.
+        unsafe {
+            (*indio_dev).name = name.as_char_ptr();
+            (*indio_dev).info = &Self::VTABLE;
+
+            let chans = (*priv_ptr).channels();
+            (*indio_dev).channels = chans.as_ptr();
+            (*indio_dev).num_channels = chans.len() as _;
+            (*indio_dev).modes = INDIO_DIRECT_MODE as i32;
+        }
+
+        Ok(Self {
+            indio_dev,
+            registered: false,
+            _p: PhantomData,
+        })
+    }
+
+    /// Registers the IIO device, making it visible to userspace via sysfs.
+    ///
+    /// On success, channel attributes like `in_angl_raw` become readable.
+    /// On failure the device stays unregistered and will be freed when
+    /// this [`Device`] is dropped.
+    #[inline]
+    pub fn register(self, module: &'static ThisModule) -> Result<Device<T, Registered>> {
+        // SAFETY: `self.indio_dev` is a valid, fully initialized `iio_dev`.
+        // `module.as_ptr()` provides the module owner for proper refcounting.
+        let ret = unsafe { __iio_device_register(self.indio_dev, module.as_ptr()) };
+        to_result(ret)?;
+
+        let registered_dev = Device {
+            indio_dev: self.indio_dev,
+            registered: true,
+            _p: PhantomData,
+        };
+
+        // Prevent `self`'s Drop from running. Ownership of `indio_dev`
+        // has been transferred to `registered_dev`.
+        forget(self);
+        Ok(registered_dev)
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9512af7156df..f565fc549b8c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -78,6 +78,8 @@
 #[cfg(CONFIG_I2C = "y")]
 pub mod i2c;
 pub mod id_pool;
+#[cfg(CONFIG_IIO)]
+pub mod iio;
 #[doc(hidden)]
 pub mod impl_flags;
 pub mod init;
-- 
2.50.0

