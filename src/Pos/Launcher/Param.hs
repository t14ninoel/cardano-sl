-- | Parameters for launching everything.

module Pos.Launcher.Param
       ( LoggingParams (..)
       , BaseParams (..)
       , NodeParams (..)
       ) where

import           Pos.Util.TimeWarp   (NetworkAddress)
import           System.Wlog         (LoggerName)
import           Universum

import           Pos.Crypto          (SecretKey)
import           Pos.DHT.Model       (DHTKey, DHTNode)
import           Pos.Security.CLI    (AttackTarget, AttackType)
import           Pos.Types           (Timestamp, Utxo)
import           Pos.Util.UserSecret (UserSecret)

-- | Contains all parameters required for hierarchical logger initialization.
data LoggingParams = LoggingParams
    { lpRunnerTag     :: !LoggerName        -- ^ prefix for logger, like "time-slave"
    , lpHandlerPrefix :: !(Maybe FilePath)  -- ^ prefix of path for all logs
    , lpConfigPath    :: !(Maybe FilePath)  -- ^ path to logger configuration
    } deriving (Show)

-- | Contains basic & networking parameters for running node.
data BaseParams = BaseParams
    { bpIpPort             :: !NetworkAddress         -- ^ port to run on
    , bpDHTPeers           :: ![DHTNode]      -- ^ peers passed from CLI
    , bpDHTKey             :: !(Maybe DHTKey)
    , bpDHTExplicitInitial :: !Bool
    , bpLoggingParams      :: !LoggingParams  -- ^ logger parameters
    , bpKademliaDump       :: !FilePath       -- ^ Path to kademlia dump file
    } deriving (Show)

-- | Contains algorithm specific & storage parameters for Node.
data NodeParams = NodeParams
    { npDbPathM       :: !FilePath          -- ^ Modern path to node's data-base.
    , npRebuildDb     :: !Bool              -- ^ @True@ if data-base should be rebuilt
    , npSystemStart   :: !Timestamp         -- ^ System start
    , npSecretKey     :: !SecretKey         -- ^ Primary secret key of node
    , npUserSecret    :: !UserSecret        -- ^ All node secret keys
    , npBaseParams    :: !BaseParams        -- ^ See 'BaseParams'
    , npCustomUtxo    :: !Utxo              -- ^ predefined custom utxo
    , npTimeLord      :: !Bool              -- ^ @True@ if node started as time-lord
    , npJLFile        :: !(Maybe FilePath)
    , npAttackTypes   :: ![AttackType]      -- ^ List of attack types used by malicious emulation
    , npAttackTargets :: ![AttackTarget]    -- ^ List of targets to attack by malicious emulation
    , npPropagation   :: !Bool              -- ^ Whether to propagate txs, ssc data, blocks to neighbors
    , npUpdateExePath :: !FilePath          -- ^ Path to update installer executable, downloaded by update system
    } deriving (Show)
