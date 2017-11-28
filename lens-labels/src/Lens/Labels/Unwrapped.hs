{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE UndecidableInstances #-}
#if __GLASGOW_HASKELL__ >= 802
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -fno-warn-simplifiable-class-constraints #-}
#endif
{-# OPTIONS_GHC -fno-warn-orphans #-}

------------------------------------------------------------------------------
-- | This module provides OverloadedLabels 'IsLabel' support via an orphan
-- instance. This means a 'LensFn' with the label @"foo"@ can be referenced
-- as @#foo@.
--
-- This can eliminate the need to call 'runLens' when working with libraries
-- like @lens-family-core@.
module Lens.Labels.Unwrapped where

import GHC.OverloadedLabels (IsLabel (..))
import Lens.Labels (LensFn (..))

instance IsLabel x (LensFn p q) => IsLabel x (p -> q) where
#if __GLASGOW_HASKELL__ >= 802
  fromLabel = runLens $ fromLabel @x
#else
  fromLabel x = runLens $ fromLabel x
#endif
